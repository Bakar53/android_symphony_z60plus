#!/system/bin/sh
# Save kernel logs to /cache/twrp (preferred) or fallback to other writable dirs.
# This script is intentionally conservative and will not block init.

CACHE_DIR=/cache/twrp
ALT_DIRS="/data/local/tmp/twrp /tmp/twrp /mnt/vendor/debug/twrp"

# Ensure preferred cache dir exists
mkdir -p "$CACHE_DIR" 2>/dev/null || true

OUTDIR=""
if [ -w "$CACHE_DIR" ] || (mkdir -p "$CACHE_DIR" 2>/dev/null && [ -w "$CACHE_DIR" ]); then
    OUTDIR="$CACHE_DIR"
else
    for d in $ALT_DIRS; do
        mkdir -p "$d" 2>/dev/null || true
        if [ -w "$d" ]; then
            OUTDIR="$d"
            break
        fi
    done
fi

# Final fallback: /tmp
if [ -z "$OUTDIR" ]; then
    OUTDIR=/tmp
fi

PREFIX="$OUTDIR/twrp"
mkdir -p "$OUTDIR" 2>/dev/null || true

# Capture dmesg
if command -v dmesg >/dev/null 2>&1; then
    dmesg > "$PREFIX-dmesg.log" 2>&1 || true
fi

# Capture /proc/last_kmsg (older kernels)
if [ -r /proc/last_kmsg ]; then
    cat /proc/last_kmsg > "$PREFIX-last_kmsg.log" 2>&1 || true
fi

# Try to copy pstore/ramoops entries
if [ -d /sys/fs/pstore ]; then
    for f in /sys/fs/pstore/*; do
        if [ -e "$f" ]; then
            cp -a "$f" "$PREFIX-$(basename "$f")" 2>/dev/null || cat "$f" > "$PREFIX-$(basename "$f")" 2>/dev/null || true
        fi
    done
fi

# Dump proc kmsg in background if readable
if [ -r /proc/kmsg ]; then
    cat /proc/kmsg > "$PREFIX-proc_kmsg.log" 2>&1 &
fi

date > "$PREFIX-saved_timestamp.txt" 2>/dev/null || true
echo "saved_to=$OUTDIR" > "$PREFIX-status.txt" 2>/dev/null || true

exit 0
