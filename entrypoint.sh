#!/bin/bash
set -e

# Start spyserver in background
/opt/spyserver/spyserver /opt/spyserver/spyserver.config &

# Start hfp_tcp in foreground (so container doesn't exit)
/usr/local/bin/hfp_tcp
