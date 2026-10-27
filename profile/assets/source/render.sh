#!/bin/sh
# Renders readme-images.html to profile/assets/banner-<theme>.png at 2x with headless Firefox.
# Run from a QuoteUs workspace that has website/ next to .github/ (for the fonts and logos), with the
# workspace served at http://localhost:${PORT:-8765}/ by any static server.
set -e
cd "$(dirname "$0")"
OUT="$(cd .. && pwd)"
FIREFOX="${FIREFOX:-/Applications/Firefox.app/Contents/MacOS/firefox}"
BASE="http://localhost:${PORT:-8765}/.github/profile/assets/source/readme-images.html"
PROFILE="$(mktemp -d)"

# The page is drawn at zoom 2: 1280×560 CSS pixels become a 2560×1120 PNG.
for theme in light dark; do
  "$FIREFOX" --headless --profile "$PROFILE" --no-remote \
    --window-size 2560,1120 --screenshot "$OUT/banner-$theme.png" "$BASE#banner-$theme"
done
rm -rf "$PROFILE"
