#!/bin/bash

# --- Disable Screen Blanking and Power Management ---
sleep 5
xset s off
xset s noblank
xset -dpms

# --- Define URLs and Window Titles ---
URL1="https://avar.act.gov.au/webapp/dashboard?showRadar=false&showWidget=false"
TITLE1="AVAR" # IMPORTANT: This must match the window title

URL2="https://bushfire.io/?location=9.126038125004253/-35.317852068618095/149.2168482514797/satellite/0/0"
TITLE2="webscreen" # IMPORTANT: This must match the window title

# --- Launch Chromium Instances in the background ---
# They will launch on the primary display first
chromium-browser --kiosk --no-first-run --disable-infobars --user-data-dir="/home/kioskuser/.config/chromium_instance1" "$URL1" &
chromium-browser --kiosk --no-first-run --disable-infobars --user-data-dir="/home/kioskuser/.config/chromium_instance2" "$URL2" &

# --- Wait for windows to appear and then move them ---
# Give the browsers time to load their windows and titles
echo "Waiting for browser windows to appear..."
sleep 10 

# Move and resize windows using their titles
# The format is: wmctrl -r "title" -e gravity,X,Y,Width,Height
echo "Moving windows to their designated displays..."
wmctrl -r "$AVAR" -e 0,0,0,3840,2160
wmctrl -r "$webscreen" -e 0,3840,0,3840,2160

echo "Kiosk setup complete."
