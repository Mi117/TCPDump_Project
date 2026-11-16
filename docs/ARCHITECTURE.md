# Architecture

## Overview

`TCPDump_Project` is a small but structured toolkit around **tcpdump**.
It is organised so new capture features and (later) a user-facing interface
can be added without rewriting the core.

```text
TCPDump_Project/
├── README.md                  # project overview + walkthrough
├── LICENSE                    # MIT
├── CONTRIBUTING.md            # how to contribute
├── ROADMAP.md                 # planned features
├── .gitignore                 # capture outputs are never committed
├── .github/
│   └── workflows/
│       └── shellcheck.yml     # CI: lint shell scripts
├── src/
│   └── logger.sh              # unified logging CLI (main tool)
├── scripts/
│   ├── checkspy.sh            # SSH capture (port 22)
│   ├── key_extraction.sh      # SSL key capture + NASA host capture
│   └── watchdog.sh            # short packet-count capture
├── config/
│   └── logger.conf.example    # example configuration
├── tests/
│   └── test_scripts.sh        # syntax checks for all scripts
├── docs/
│   ├── ARCHITECTURE.md        # this file
│   ├── USAGE.md               # detailed usage guide
│   ├── TCP Dump_Tasks breakdown.pdf
│   └── TCPDump Quick Reference.pdf
└── screenshots/               # visual proof of the lab work
    └── README.md              # index of all walkthrough images
```

## Components

| Component | Role |
|---|---|
| `src/logger.sh` | Single entry point: interface, filter, output, rotation, packet count, SSL key path |
| `scripts/*.sh` | Original task scripts kept as coursework evidence |
| `config/logger.conf.example` | Defaults ready to be loaded by future config support |
| `tests/test_scripts.sh` | `bash -n` syntax checks (+ shellcheck when available) |
| `.github/workflows/shellcheck.yml` | CI lint on push / PR |

## Data flow

```text
user -> src/logger.sh -> tcpdump -> *.pcap
                               \-> sslkeys.log (TLS keys)
                                          |
                                     Wireshark (decrypt)
```

## Extension points

- **Filter presets:** add flags to `src/logger.sh` (e.g. `--preset ssh`).
- **Config file loading:** source `config/logger.conf` when present.
- **UI layer:** a TUI (dialog/whiptail) or web dashboard can call
  `src/logger.sh` as a backend, keeping capture logic in one place.
- **CI:** `tests/` and `.github/workflows/` are ready for more checks.

## Design principles

1. Keep tcpdump as the single capture engine.
2. Wrap it with predictable options, quoting and error handling.
3. Never commit capture files or key logs.
4. Document every feature with examples and screenshots.
