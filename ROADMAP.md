# Roadmap

## Done

- [x] Core packet capture scripts (`scripts/checkspy.sh`, `scripts/key_extraction.sh`, `scripts/watchdog.sh`)
- [x] Unified logging tool (`src/logger.sh`)
- [x] Configuration example (`config/logger.conf.example`)
- [x] Documentation (`docs/USAGE.md`, `docs/ARCHITECTURE.md`)
- [x] Visual walkthrough (screenshots)
- [x] Initial repository setup
- [x] CI: shellcheck lint + script tests on every push

## Next — upcoming iterations (next months)

### Iteration 1 — Usability
- [ ] Add filter presets (SSH, HTTP/HTTPS, DNS, custom sets) to `src/logger.sh`

### Iteration 2 — Observability
- [ ] Live capture statistics / summary reports

### Iteration 3 — UX
- [ ] Interactive CLI menu (TUI)

### Iteration 4 — Platform
- [ ] Web dashboard interface to manage captures

### Iteration 5 — Operations
- [ ] Install / packaging script (single-command setup)

## Ideas

- [ ] Capture scheduling and retention policies
- [ ] Automatic Wireshark integration
- [ ] Cross-platform support notes (macOS / BSD)
