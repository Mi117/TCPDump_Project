# Usage

## Requirements

- Linux (Debian / Kali tested)
- `tcpdump`
- `sudo` / root for capture
- *optional:* Wireshark for analysis, Chrome/Chromium for `SSLKEYLOGFILE`

```bash
sudo apt update && sudo apt install -y tcpdump
```

## Unified tool: `src/logger.sh`

```bash
chmod +x src/logger.sh
./src/logger.sh --help
```

### Examples

```bash
# Capture all traffic on all interfaces into capture.pcap (600s / 2MB rotation)
./src/logger.sh

# SSH traffic only
./src/logger.sh -f "port 22" -o proof.pcap

# HTTPS traffic on a specific interface
./src/logger.sh -i eth0 -f "port 443" -o https.pcap

# Watchdog: stop after 10 packets to a host, rotate 15s / 1MB
./src/logger.sh -c 10 -f "host 10.0.2.15" -t 15 -s 1 -o capture.pcap

# List interfaces
./src/logger.sh -D
```

### Options

| Flag | Meaning |
|---|---|
| `-i, --interface IFACE` | interface (default `any`) |
| `-f, --filter EXPR` | tcpdump filter expression |
| `-o, --output FILE` | output pcap (default `capture.pcap`) |
| `-t, --rotate-time SEC` | rotate every SEC seconds (0 = off) |
| `-s, --rotate-size MB` | rotate after MB megabytes (0 = off) |
| `-c, --count N` | stop after N packets (0 = unlimited) |
| `-k, --ssl-keys PATH` | export `SSLKEYLOGFILE` |
| `-D, --list-interfaces` | list interfaces |
| `-h, --help` | help |

## Task scripts

```bash
sudo ./scripts/checkspy.sh        # SSH capture -> proof.pcap
sudo ./scripts/key_extraction.sh  # SSL keys + capture -> capture.pcap
sudo ./scripts/watchdog.sh        # 10 packets -> capture.pcap
```

## Decrypting TLS in Wireshark

1. Set `SSLKEYLOGFILE` (or use `-k`) before starting the browser.
2. In Wireshark: **Edit → Preferences → Protocols → TLS**.
3. Set **Pre-Master-Secret log filename** to the key log.
4. Open the captured `.pcap` and inspect the decrypted application data.

## Notes

- `-G` / `-C` only make sense together with `-w` (the logger always sets it).
- Capture files and key logs are ignored by `.gitignore` — keep them private.
