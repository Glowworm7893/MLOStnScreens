#!/bin/bash

# --- Disable Screen Blanking and Power Management ---
sleep 5
xset s off
xset s noblank
xset -dpms

# --- Define URLs and Window Titles ---
URL1="https://avar.act.gov.au/webapp/dashboard?showRadar=false&showWidget=false"
TITLE1="AVAR" # IMPORTANT: This must match the window title

# Define the URLs for the multiple tabs
URL2="https://bushfire.io/?location=9.126038125004253/-35.317852068618095/149.2168482514797/satellite/0/0" #Bushfire.io general situational awarness
URL3="https://esa.act.gov.au/?fullmap=true" # ACTESA Incident Map
URL4="https://centralwatch.watchtowers.io/au?camera=8ba6c383-dc8a-4640-8c23-8424af64b6a2" # Kowen Forest - Guard
URL5="https://centralwatch.watchtowers.io/au?camera=7344e0ee-1baf-4d07-930d-f0aab8a42086" # Mt Coree
URL6="https://centralwatch.watchtowers.io/au?camera=0c0bd91f-8498-4236-9be7-785c80ea8c89" # Stromlo
URL7="https://centralwatch.watchtowers.io/au?camera=0afbd08e-f28c-4bd8-a8b2-82b7a1c573de" #Tennant
URL8="https://centralwatch.watchtowers.io/au?camera=0b51e2da-156a-4906-a303-9d37ffa6120c" #OneTreeHill
TITLE2="webscreen" # IMPORTANT: This must match the window title

# --- Launch Chromium Instances in the background ---
# They will launch on the primary display first
chromium-browser --new-window --kiosk --no-first-run --disable-infobars --user-data-dir="/home/kioskuser/.config/chromium_instance1" "$URL1" &
# Launch the second Chromium instance with multiple URLs and the TabCycle extension
# The --enable-extension-apps flag ensures extensions run correctly
chromium-browser --new-window --kiosk --no-first-run --disable-infobars --enable-extension-apps --user-data-dir="/home/kioskuser/.config/chromium_instance2" "$URL2" "$URL3" "$URL4" "$URL5" "$URL6" "$URL7" "$URL8" &

# --- Wait for windows to appear and then move them ---
# Give the browsers time to load their windows and titles
echo "Waiting for browser windows to appear..."
sleep 10 

# Move and resize windows using their titles
# The format is: wmctrl -r "title" -e gravity,X,Y,Width,Height
echo "Moving windows to their designated displays..."
# The variable names were incorrect in the original script, so they have been updated
wmctrl -r "$TITLE1" -e 0,0,0,3840,2160
wmctrl -r "$TITLE2" -e 0,3840,0,3840,2160

echo "Kiosk setup complete."
