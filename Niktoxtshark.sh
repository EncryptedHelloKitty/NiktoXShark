#!/bin/bash

# Function to print messages in color
print_info() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

print_success() {
    echo -e "\033[1;32m[SUCCESS]\033[0m $1"
}

print_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Prompt for website URL
read -p "Enter the website URL to scan: " URL

# Prompt for network interface
read -p "Enter the network interface to monitor (e.g., eth0, wlan0): " INTERFACE

# Prompt for duration (optional, default to 30 seconds)
read -p "Enter the duration for Tshark capture in seconds (default is 30): " DURATION
DURATION=${DURATION:-30} # Use default if no input

NIKTO_REPORT="nikto_report.txt"
TSHARK_CAPTURE="tshark_capture.pcap"
TSHARK_SUMMARY="tshark_summary.txt"

# Step 1: Start Tshark to monitor traffic
print_info "Starting Tshark capture on interface $INTERFACE for $DURATION seconds..."
tshark -i "$INTERFACE" -a duration:"$DURATION" -w "$TSHARK_CAPTURE" >/dev/null 2>&1 &
TSHARK_PID=$!

# Step 2: Run Nikto scan
print_info "Running Nikto scan on $URL..."
nikto -h "$URL" -o "$NIKTO_REPORT" -Format txt >/dev/null 2>&1

# Wait for Tshark to finish capturing traffic
wait $TSHARK_PID
print_success "Tshark capture completed."

# Step 3: Summarize Nikto results
if [ -f "$NIKTO_REPORT" ]; then
    print_success "Nikto scan completed. Summarizing results..."
    echo -e "\n\033[1;36m----------------- NIKTO SUMMARY -----------------\033[0m"
    grep -E "Target|+ OSVDB|+ OSVDB-|" "$NIKTO_REPORT" | sed 's/^+ //'
    echo -e "\033[1;36m-------------------------------------------------\033[0m"
else
    print_error "Nikto scan failed."
fi

# Step 4: Analyze Tshark capture
if [ -f "$TSHARK_CAPTURE" ]; then
    print_info "Analyzing Tshark capture..."
    tshark -r "$TSHARK_CAPTURE" -q -z io,phs > "$TSHARK_SUMMARY"

    echo -e "\n\033[1;36m----------------- TSHARK SUMMARY ----------------\033[0m"
    cat "$TSHARK_SUMMARY"
    echo -e "\033[1;36m-------------------------------------------------\033[0m"
else
    print_error "Tshark capture file not found."
fi

# Cleanup (Optional: Comment out if you want to keep files)
rm -f "$NIKTO_REPORT" "$TSHARK_CAPTURE" "$TSHARK_SUMMARY"
