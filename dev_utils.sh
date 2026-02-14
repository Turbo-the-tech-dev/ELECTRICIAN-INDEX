#!/bin/bash
# Utility script with useful commands for managing your development environment

echo "=== Development Environment Utilities ==="
echo "1. Disk usage by directory"
echo "2. Clean Python cache files"
echo "3. List running Python processes"
echo "4. Show directory tree (if tree is installed)"
echo "5. Find largest files"
echo "6. Backup Projects folder"
echo "========================================="

case $1 in
    1)
        echo "Disk usage by directory:"
        du -sh * 2>/dev/null | sort -h
        ;;
    2)
        echo "Cleaning Python cache files..."
        find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null && echo "Removed __pycache__ directories"
        find . -name "*.pyc" -delete 2>/dev/null && echo "Deleted .pyc files"
        ;;
    3)
        echo "Running Python processes:"
        ps aux | grep python
        ;;
    4)
        if command -v tree &> /dev/null; then
            echo "Directory tree (2 levels deep):"
            tree -L 2 -d
        else
            echo "tree command not found. Install with: pkg install tree"
        fi
        ;;
    5)
        echo "Top 20 largest files:"
        find . -type f -exec du -h {} + 2>/dev/null | sort -rh | head -20
        ;;
    6)
        echo "Creating backup of Projects folder..."
        if [ -d "Projects" ]; then
            tar -czf projects_backup_$(date +%Y%m%d_%H%M%S).tar.gz Projects/
            echo "Backup created: projects_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
        else
            echo "Projects directory not found in current location."
        fi
        ;;
    *)
        echo "Usage: $0 {1|2|3|4|5|6}"
        echo "  1: Disk usage by directory"
        echo "  2: Clean Python cache files"
        echo "  3: List running Python processes"
        echo "  4: Show directory tree"
        echo "  5: Find largest files"
        echo "  6: Backup Projects folder"
        ;;
esac