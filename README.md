# Project Name: NiktoXShark

This script combines web vulnerability scanning using `Nikto` and network traffic monitoring using `Tshark`. It is designed to provide a quick and efficient way to gather preliminary information about a target website and network interface.

## Features

1. **Network Traffic Monitoring**: Captures network traffic on a specified interface for a given duration using `Tshark`.
2. **Web Vulnerability Scanning**: Scans the specified website for vulnerabilities using `Nikto`.
3. **Automatic Summary**:
   - Extracts key findings from the `Nikto` scan.
   - Summarizes the network traffic captured by `Tshark`.

## Dependencies

Ensure the following tools are installed before running the script:
- `tshark`
- `nikto`

## Installation

1. Install the required tools:
    ```bash
    sudo apt-get update
    sudo apt-get install -y tshark nikto
    ```

2. Clone the repository or download the script:
    ```bash
    git clone https://github.com/yourusername/basic-web-scan.git
    cd basic-web-scan
    ```

3. Make the script executable:
    ```bash
    chmod +x web_scan.sh
    ```

## Usage

1. Run the script:
    ```bash
    ./web_scan.sh
    ```

2. Follow the prompts to:
    - Enter the website URL to scan.
    - Specify the network interface to monitor (e.g., `eth0`, `wlan0`).
    - Set the duration for the network traffic capture (default is 30 seconds).

## Output

- **Nikto Scan Results**:
  - Stored in `nikto_report.txt` during execution.
  - A summarized report is displayed in the terminal.

- **Tshark Network Capture**:
  - Stored in `tshark_capture.pcap`.
  - A summarized traffic report is displayed in the terminal.

## Cleanup

Temporary files are automatically deleted after the script completes execution:
- `nikto_report.txt`
- `tshark_capture.pcap`
- `tshark_summary.txt`

To retain these files, comment out the `rm -f` line at the end of the script.

## Disclaimer

This script is for educational and authorized testing purposes only. Ensure you have proper authorization before scanning any target or monitoring network traffic.


