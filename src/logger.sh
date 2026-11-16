#!/bin/bash
# ============================================================
# TCPDump_Project - unified logging tool
# ------------------------------------------------------------
# Builds a single, well-behaved wrapper around tcpdump so that
# capture, filtering, rotation and TLS-key logging can be used
# from one place (and later from a UI).
#
# Requires: tcpdump (Linux), sudo privileges, bash >= 4.
# ============================================================
set -euo pipefail

PROG="$(basename "$0")"

usage() {
    cat <<EOF
Usage: $PROG [OPTIONS]

Capture network traffic with tcpdump.

Options:
  -i, --interface IFACE      Interface to capture on (default: any)
  -f, --filter EXPR          tcpdump filter (e.g. "port 22", "host 1.2.3.4")
  -o, --output FILE          Output pcap file (default: capture.pcap)
  -t, --rotate-time SEC      Rotate output every SEC seconds (default: 600, 0 = off)
  -s, --rotate-size MB       Rotate output after MB megabytes (default: 2, 0 = off)
  -c, --count N              Stop after N packets (default: 0 = unlimited)
  -k, --ssl-keys PATH        Export SSLKEYLOGFILE=PATH (TLS key capture)
  -D, --list-interfaces      List available interfaces and exit
  -h, --help                 Show this help

Examples:
  $PROG -i eth0 -f "port 443" -o https.pcap
  $PROG -c 10 -f "host 10.0.2.15" -o watchdog.pcap
  $PROG -f "port 22" -t 600 -s 2 -o proof.pcap
  $PROG -k /home/kali/tcpdump_project/sslkeys.log -f "host example.com"
EOF
}

INTERFACE="any"
FILTER=""
OUTPUT="capture.pcap"
ROTATE_TIME=600
ROTATE_SIZE=2
COUNT=0
SSL_KEYS=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--interface)      INTERFACE="$2"; shift 2 ;;
        -f|--filter)         FILTER="$2"; shift 2 ;;
        -o|--output)         OUTPUT="$2"; shift 2 ;;
        -t|--rotate-time)    ROTATE_TIME="$2"; shift 2 ;;
        -s|--rotate-size)    ROTATE_SIZE="$2"; shift 2 ;;
        -c|--count)          COUNT="$2"; shift 2 ;;
        -k|--ssl-keys)       SSL_KEYS="$2"; shift 2 ;;
        -D|--list-interfaces) exec tcpdump -D ;;
        -h|--help)           usage; exit 0 ;;
        *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
    esac
done

if ! command -v tcpdump >/dev/null 2>&1; then
    echo "error: tcpdump is not installed" >&2
    exit 1
fi

if [[ -n "$SSL_KEYS" ]]; then
    export SSLKEYLOGFILE="$SSL_KEYS"
    echo "[*] SSLKEYLOGFILE=$SSLKEYLOGFILE"
fi

cmd=(sudo tcpdump -i "$INTERFACE" -w "$OUTPUT")

if (( COUNT > 0 )); then
    cmd+=(-c "$COUNT")
fi
if (( ROTATE_TIME > 0 )); then
    cmd+=(-G "$ROTATE_TIME")
fi
if (( ROTATE_SIZE > 0 )); then
    cmd+=(-C "$ROTATE_SIZE")
fi
if [[ -n "$FILTER" ]]; then
    # shellcheck disable=SC2206 # filter is intentionally word-split
    cmd+=($FILTER)
fi

echo "[*] Running: ${cmd[*]}"
"${cmd[@]}"
