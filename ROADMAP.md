# Roadmap

## Done

- [x] Core packet capture scripts (`scripts/checkspy.sh`, `scripts/key_extraction.sh`, `scripts/watchdog.sh`)
- [x] Unified logging tool (`src/logger.sh`)
- [x] Configuration example (`config/logger.conf.example`)
- [x] Documentation (`docs/USAGE.md`, `docs/ARCHITECTURE.md`)
- [x] Visual walkthrough (screenshots)
- [x] Initial repository setup
- [x] CI: shellcheck lint + script tests on every push

## Next

- [ ] Add filter presets (SSH, HTTP/HTTPS, DNS, custom sets)
- [ ] Live capture statistics / summary reports
- [ ] Interactive CLI menu (TUI)
- [ ] Web dashboard interface to manage captures
- [ ] Install / packaging script (single-command setup)

## Ideas

- [ ] Capture scheduling and retention policies
- [ ] Automatic Wireshark integration
- [ ] Cross-platform support notes (macOS / BSD)
