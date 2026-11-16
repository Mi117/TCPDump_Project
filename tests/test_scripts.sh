#!/bin/bash
# ============================================================
# TCPDump_Project - script checks
# Validates shebangs and bash syntax for every project script.
# Uses only bash builtins for path resolution and file reading,
# so it also runs on minimal shells / Windows Git Bash.
# ============================================================
set -u

# Resolve the repository root without external tools (no dirname).
SCRIPT_DIR="${0%/*}"
if [ "$SCRIPT_DIR" = "$0" ]; then
    SCRIPT_DIR="."
fi
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

FAILED=0

echo "== shebang checks =="
for f in "$ROOT"/src/*.sh "$ROOT"/scripts/*.sh "$ROOT"/tests/*.sh; do
    [ -e "$f" ] || continue
    first=""
    IFS= read -r first < "$f" || true
    if [ "$first" = "#!/bin/bash" ]; then
        echo "OK   $f"
    else
        echo "FAIL $f (missing or invalid #!/bin/bash)"
        FAILED=1
    fi
done

echo
echo "== bash -n syntax checks =="
for f in "$ROOT"/src/*.sh "$ROOT"/scripts/*.sh "$ROOT"/tests/*.sh; do
    [ -e "$f" ] || continue
    if bash -n "$f"; then
        echo "OK   $f"
    else
        echo "FAIL $f"
        FAILED=1
    fi
done

if command -v shellcheck >/dev/null 2>&1; then
    echo
    echo "== shellcheck =="
    for f in "$ROOT"/src/*.sh "$ROOT"/scripts/*.sh "$ROOT"/tests/*.sh; do
        [ -e "$f" ] || continue
        if shellcheck "$f"; then
            echo "OK   $f"
        else
            echo "FAIL $f"
            FAILED=1
        fi
    done
else
    echo
    echo "shellcheck not installed - skipped"
fi

exit "$FAILED"
