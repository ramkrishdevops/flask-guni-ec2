
#!/usr/bin/env bash
set -e

# === Your environment ===
APP_DIR="/home/ubuntu/flask-guni-ec2"
SERVICE_NAME="flaskapp"            # if your unit is gunicorn.service
HEALTH_URL="http://localhost:8000/health"

case "$1" in
  install)
    echo "[install] Ensuring ownership"
    chown -R ubuntu:ubuntu "$APP_DIR"
    ;;
  stop)
    echo "[stop] Stopping $SERVICE_NAME.service (if running)"
    systemctl stop "$SERVICE_NAME.service" || true
    ;;
  start)
    echo "[start] Starting $SERVICE_NAME.service"
    systemctl daemon-reload
    systemctl start "$SERVICE_NAME.service"
    ;;
  health)
    echo "[health] Checking $HEALTH_URL"
    for i in {1..10}; do
      if curl -fsS "$HEALTH_URL" >/dev/null; then
        echo "[health] Healthy"
        exit 0
      fi
      sleep 3
    done
    echo "[health] FAILED"
    # show last 100 lines from journal to aid triage
    journalctl -u "$SERVICE_NAME.service" --no-pager -n 100 || true
    exit 1
    ;;
  *)
    echo "Usage: $0 {install|stop|start|health}"
    exit 2
    ;;
es

