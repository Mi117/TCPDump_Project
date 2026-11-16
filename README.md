# TCPDump_Project — Build a Logging Tool

**Analyze Network Traffic with TCPDump: Build a Logging Tool**

A personal cybersecurity project that builds a **network logging tool** on top of **`tcpdump`** — capturing, filtering, rotating and decrypting network traffic — executed inside a **Debian (Kali Linux) VM** managed by **Oracle VirtualBox**.

## What is tcpdump?

`tcpdump` is a command-line packet capture utility for Unix-like operating systems (Linux / BSD / macOS). It requires superuser privileges to run and captures raw network packets. It supports capturing on any interface (`-i <iface>`), filtering by protocol/port/host/src/dst, writing captures to files (`-w file.pcap`) and reading them back (`-r file.pcap`), rotating dump files (`-G <seconds>`, `-C <size-in-MB>`), and displaying packets in different formats (`-A`, `-XX`, `-#`, `-tttt`).

> tcpdump does **not** decrypt encrypted traffic by itself — companion tooling (browser `SSLKEYLOGFILE` + Wireshark TLS pre-master secret log) is used for decryption.

## What does this tool do?

This project implements the objectives of the "Build a Logging Tool" coursework:

1. **Task 1 – Getting Started:** capture network traffic with tcpdump; superuser required; no native decryption.
2. **Task 2 – Shell Script + Targeting:** build the logging shell script; list interfaces (`tcpdump -D`), isolate interface (`tcpdump -i abc`), limit capture by host/IP/src/dst/port.
3. **Task 3 – Save and Read:** write captures with `-w abc.pcap`, read with `-r abc.pcap`; use Wireshark to analyze.
4. **Task 4 – Sequential Dumps:** rotate dump files by time (`-G n`) and size (`-C n`).
5. **Task 5 – SSL Keys + Wireshark:** set `SSLKEYLOGFILE` and point Wireshark at the TLS pre-master secret log to decode encrypted traffic.

## Repository Structure

```text
TCPDump_Project/
├── README.md
├── screenshots/
├── scripts/
└── docs/
```

## The Scripts

### scripts/checkspy.sh

```bash
#!/bin/bash
sudo tcpdump port 22 -i any -G 600 -C 2 -w proof.pcap
```

Captures SSH traffic (`port 22`), writes to `proof.pcap`, rotating every 600 s / 2 MB.

### scripts/key_extraction.sh

```bash
#!/bin/bash
export SSLKEYLOGFILE=/home/kali/tcpdump_project/sslkeys.log
/usr/bin/google-chrome-stable &
sudo tcpdump host apd.nasa.gov -w capture.pcap -G 600 -C 1
```

Extracts SSL/TLS keys via `SSLKEYLOGFILE`, launches Chrome, captures traffic to `apd.nasa.gov`.

### scripts/watchdog.sh

```bash
#!/bin/bash
sudo tcpdump -c 10 host 10.0.2.15 -C 1 -G 15 -w capture.pcap
```

Watchdog capture — first 10 packets to host `10.0.2.15`, rotating 15 s / 1 MB.

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

## Instructions / Usage

- Install: `sudo apt install tcpdump`
- Run: `sudo tcpdump [options] [expression]`
- Analyze with Wireshark; set TLS pre-master secret log for decryption.
- Use scripts in `scripts/`.

## Roadmap

- Continue adding features to the logging tool.
- Add a user-facing interface for people to use on their machines.

---

*This repository was created as part of a cybersecurity degree path project: building a network logging tool with tcpdump.*
