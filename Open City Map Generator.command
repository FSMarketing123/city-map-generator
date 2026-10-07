#!/bin/bash
# Double-click to open the City Map Generator.
# The map servers only answer pages that have a web address, so this serves the
# page from this Mac (visible only to this computer) and opens it in your browser.
cd "$(dirname "$0")"
PORT=47615
URL="http://127.0.0.1:$PORT/"

if curl -s "$URL" | grep -q "City Map Generator"; then
  open "$URL"
  echo "City Map Generator is already running — opened it in your browser."
  exit 0
fi

python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
SERVER=$!
for i in 1 2 3 4 5 6 7 8 9 10; do
  curl -s -o /dev/null "$URL" && break
  sleep 0.3
done
open "$URL"
echo "City Map Generator is running at $URL"
echo "Leave this window open while you use it. Close it (or press Ctrl+C) when you're done."
trap 'kill $SERVER 2>/dev/null' EXIT
wait $SERVER
