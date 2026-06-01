#!/bin/bash
# Partner LC Dashboard Launcher
# Double-click this file to open the dashboard in your browser.

# Change to the folder where this script lives
cd "$(dirname "$0")"

# Find an open port (default 8743)
PORT=8743

# Kill anything already on that port
lsof -ti tcp:$PORT | xargs kill -9 2>/dev/null

# Start a local web server in the background
python3 -m http.server $PORT --bind 127.0.0.1 &
SERVER_PID=$!

# Give it a moment to start
sleep 1

# Open the dashboard in Chrome (or default browser)
if [ -d "/Applications/Google Chrome.app" ]; then
  open -a "Google Chrome" "http://localhost:$PORT/partner-lc-dashboard.html"
else
  open "http://localhost:$PORT/partner-lc-dashboard.html"
fi

# Keep the server running until the terminal window is closed
echo ""
echo "Partner LC Dashboard is running at http://localhost:$PORT/partner-lc-dashboard.html"
echo "Close this window to stop the server."
wait $SERVER_PID
