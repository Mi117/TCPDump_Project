# TCPDump_Project — Build a Logging Tool

**Analyze Network Traffic with TCPDump: Build a Logging Tool**

A personal cybersecurity project that builds a **network logging tool** on top of **`tcpdump`** — capturing, filtering, rotating and decrypting network traffic — executed inside a **Debian (Kali Linux) VM** managed by **Oracle VirtualBox**.

## What is tcpdump?

`tcpdump` is a command-line packet capture utility for Unix-like operating systems (Linux / BSD / macOS). It requires superuser privileges to run and captures raw network packets. It supports capturing on any interface (`-i <iface>`), filtering by protocol/port/host/src/dst, writing captures to files (`-w file.pcap`) and reading them back (`-r file.pcap`), rotating dump files (`-G <seconds>`, `-C <size-in-MB>`), and displaying packets in different formats (`-A`, `-XX`, `-#`, `-tttt`).

> tcpdump does **not** decrypt encrypted traffic by itself — companion tooling (browser `SSLKEYLOGFILE` + Wireshark TLS pre-master secret log) is used for decryption.

## Features

- Unified logging CLI — `src/logger.sh` (interface, filter, output, count, rotation, SSL keys)
- Interface selection and BPF filters (`host`, `port`, `src`, `dst`, ...)
- Output files with time-based (`-G`) and size-based (`-C`) rotation
- TLS key capture via `SSLKEYLOGFILE` for Wireshark decryption
- Ready-made task scripts (SSH proof capture, SSL key extraction, watchdog)
- Documentation, architecture notes and a visual walkthrough
- CI linting with shellcheck

## Repository Structure

```text
TCPDump_Project/
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── ROADMAP.md
├── .gitignore
├── .github/workflows/shellcheck.yml
├── src/
│   └── logger.sh
├── scripts/
│   ├── checkspy.sh
│   ├── key_extraction.sh
│   └── watchdog.sh
├── config/
│   └── logger.conf.example
├── tests/
│   └── test_scripts.sh
├── docs/
│   ├── ARCHITECTURE.md
│   ├── USAGE.md
│   ├── TCP Dump_Tasks breakdown.pdf
│   └── TCPDump Quick Reference.pdf
└── screenshots/
```

## Quick Start

```bash
git clone https://github.com/Mi117/TCPDump_Project.git
cd TCPDump_Project
chmod +x src/logger.sh scripts/*.sh

sudo apt install -y tcpdump
./src/logger.sh --help
```

### Unified logging tool

```bash
# Capture everything -> capture.pcap (600 s / 2 MB rotation)
./src/logger.sh

# SSH traffic only
./src/logger.sh -f "port 22" -o proof.pcap

# HTTPS on a specific interface
./src/logger.sh -i eth0 -f "port 443" -o https.pcap

# Watchdog: 10 packets to a host, rotate 15 s / 1 MB
./src/logger.sh -c 10 -f "host 10.0.2.15" -t 15 -s 1 -o capture.pcap

# TLS key capture
./src/logger.sh -k /home/kali/tcpdump_project/sslkeys.log -f "host example.com"
```

### Task scripts

```bash
sudo ./scripts/checkspy.sh        # SSH capture -> proof.pcap
sudo ./scripts/key_extraction.sh  # SSL keys + capture -> capture.pcap
sudo ./scripts/watchdog.sh        # 10 packets -> capture.pcap
```

## What does this tool do?

This project implements the objectives of the "Build a Logging Tool" coursework:

1. **Task 1 – Getting Started:** capture network traffic with tcpdump; superuser required; no native decryption.
2. **Task 2 – Shell Script + Targeting:** build the logging shell script; list interfaces (`tcpdump -D`), isolate interface (`tcpdump -i abc`), limit capture by host/IP/src/dst/port.
3. **Task 3 – Save and Read:** write captures with `-w abc.pcap`, read with `-r abc.pcap`; use Wireshark to analyze.
4. **Task 4 – Sequential Dumps:** rotate dump files by time (`-G n`) and size (`-C n`).
5. **Task 5 – SSL Keys + Wireshark:** set `SSLKEYLOGFILE` and point Wireshark at the TLS pre-master secret log to decode encrypted traffic.

## Walkthrough — Visual Proof of the Work

### 1. Basic Commands

![Basic tcpdump commands](screenshots/1_Basic%20commands.png)

### 2. Listing Interfaces

```bash
sudo tcpdump -D
```

### 3. Isolating an Interface

```bash
sudo tcpdump -i abc
```

### 4. Filtering Traffic

Limit captures by host / IP / port / src / dst.

### 5. Creating the Capture File

```bash
sudo tcpdump -w capture.pcap
```

### 6. Displaying Captured Packets / Encrypted Traffic with Wireshark

Use Wireshark to read captures; encrypted application data can be decoded via SSL keys.

### 7. Multiple Capture Files / Size Limits

Rotating dumps with `-C` and `-G`.

### VirtualBox Environment

![Kali Linux running in Oracle VirtualBox](screenshots/2025-06-17%2015_03_47-kali-linux-2025.1c-virtualbox-amd64%20[Running]%20-%20Oracle%20VirtualBox.png)

## Documentation

- [`docs/USAGE.md`](docs/USAGE.md) — detailed usage
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — repo architecture
- [`ROADMAP.md`](ROADMAP.md) — planned features
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — how to contribute

## Roadmap

- [ ] Filter presets and reports
- [ ] Interactive CLI (TUI) and web dashboard
- [ ] Installer / packaging
- [ ] CI checks

## License

MIT — see [`LICENSE`](LICENSE).

---

*This repository was created as part of a cybersecurity degree path project: building a network logging tool with tcpdump.*
