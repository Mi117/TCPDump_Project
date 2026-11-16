# Contributing

Thanks for your interest in improving **TCPDump_Project**.

## Workflow

1. Fork the repository and create a feature branch:
   ```bash
   git checkout -b feature/my-feature
   ```
2. Make your changes in `src/`, `scripts/`, `config/` or `docs/`.
3. Lint the shell scripts locally:
   ```bash
   shellcheck src/*.sh scripts/*.sh tests/*.sh
   ```
4. Commit with a clear message:
   ```bash
   git commit -m "feat: add DNS filter preset"
   ```
5. Push and open a Pull Request.

## Guidelines

- Keep shell scripts POSIX-friendly where possible and quote variables.
- Never commit capture files (`*.pcap`, `sslkeys.log`) — they may contain sensitive data.
- Update `docs/` and `ROADMAP.md` when adding features.
- Test your changes on Linux (the project targets Linux guests / hosts).

## Reporting issues

Open a GitHub issue with:
- what you expected,
- what happened,
- the exact command and output.
