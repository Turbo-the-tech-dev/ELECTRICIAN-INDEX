#!/bin/bash
# Useful one-liners and productivity scripts for developers

echo "=== Developer Productivity Scripts ==="

case $1 in
    1)
        # Count lines of code (excluding empty lines, comments)
        echo "Counting lines of Python code (excluding empty lines and comments):"
        find . -name "*.py" -not -path "*/venv/*" -not -path "*/__pycache__/*" | xargs cat 2>/dev/null | grep -v "^\s*$" | grep -v "^\s*#" | wc -l
        ;;
    2)
        # Create timestamped backup
        if [ -z "$2" ]; then
            echo "Usage: $0 2 <filename>"
            exit 1
        fi
        if [ ! -f "$2" ]; then
            echo "File $2 not found!"
            exit 1
        fi
        cp "$2"{,.$(date +%Y%m%d_%H%M%S)}
        echo "Created backup: $2.$(date +%Y%m%d_%H%M%S)"
        ;;
    3)
        # Extract all .tar.gz files
        echo "Looking for .tar.gz files in current directory..."
        for f in *.tar.gz; do
            if [ -f "$f" ]; then
                echo "Extracting $f..."
                tar -xzf "$f"
            else
                echo "No .tar.gz files found in current directory."
                break
            fi
        done
        ;;
    4)
        # Disk usage sorted by size
        echo "Disk usage by directory/file (sorted by size):"
        du -sh * 2>/dev/null | sort -h
        ;;
    5)
        # Find TODO/FIXME in code
        echo "Searching for TODO and FIXME in code files..."
        grep -r --include="*.{py,js,html,css,md,txt}" -n "TODO\|FIXME\|BUG\|HACK" . 2>/dev/null
        ;;
    *)
        echo "Usage: $0 {1|2|3|4|5} [arguments]"
        echo "  1: Count lines of code (excluding empty lines and comments)"
        echo "  2: Create timestamped backup (requires filename)"
        echo "  3: Extract all .tar.gz files in current directory"
        echo "  4: Show disk usage sorted by size"
        echo "  5: Find TODO/FIXME in code files"
        ;;
esac