# syntax=docker/dockerfile:1.4

### Stage 1: Build libairspyhf + hfp_tcp
FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    pkg-config \
    libusb-1.0-0-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Build libairspyhf
WORKDIR /build
RUN git clone --depth 1 https://github.com/airspy/airspyhf.git
WORKDIR /build/airspyhf
RUN mkdir build && cd build && cmake .. && make -j$(nproc) && make install

# Build hfp_tcp
WORKDIR /build
RUN git clone --depth 1 https://github.com/gruenwelt/hfp_tcp.git
WORKDIR /build/hfp_tcp
RUN make -j$(nproc)

### Stage 2: Runtime
FROM debian:bookworm-slim

# Install runtime deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    libusb-1.0-0 \
    tini \
    && rm -rf /var/lib/apt/lists/*

# Copy libairspyhf and hfp_tcp from build stage
COPY --from=builder /usr/local /usr/local
COPY --from=builder /build/hfp_tcp/hfp_tcp /usr/local/bin/hfp_tcp

# Prepare spyserver directory
RUN mkdir -p /opt/spyserver
COPY spyserver*.tar /opt/spyserver/
WORKDIR /opt/spyserver

# Extract spyserver binary and config
RUN tar -xvf spyserver*.tar && rm spyserver*.tar \
    && chmod +x /opt/spyserver/spyserver \
    && mkdir -p /opt/spyserver/conf

# Set up dynamic linker
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/local-lib.conf && ldconfig

# Add entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use tini as init system to properly handle signals
ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
