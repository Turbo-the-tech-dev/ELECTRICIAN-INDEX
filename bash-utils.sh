#!/bin/bash
# Main entry point for the Bash Utils Library
# Provides unified access to all utilities

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$LIB_DIR/scripts"

echo "=== Bash Utils Library ==="
echo "A collection of useful Bash utilities for developers"
echo ""

show_menu() {
    echo "Available utilities:"
    echo "  1) Development Utilities (dev_utils.sh)"
    echo "  2) Productivity Scripts (productivity_scripts.sh)"
    echo "  3) Simple Watch (simple_watch.sh)"
    echo "  4) View Bash Cheatsheet"
    echo "  5) Show this menu"
    echo "  0) Exit"
    echo ""
}

show_menu

while true; do
    read -p "Select an option (0-5): " choice
    
    case $choice in
        1)
            echo ""
            echo "Development Utilities:"
            echo "  1) Disk usage by directory"
            echo "  2) Clean Python cache files"
            echo "  3) List running Python processes"
            echo "  4) Show directory tree (if tree is installed)"
            echo "  5) Find largest files"
            echo "  6) Backup Projects folder"
            echo ""
            read -p "Select dev utility (1-6): " sub_choice
            case $sub_choice in
                [1-6])
                    "$SCRIPTS_DIR/dev_utils.sh" "$sub_choice"
                    ;;
                *)
                    echo "Invalid option. Please select 1-6."
                    ;;
            esac
            ;;
        2)
            echo ""
            echo "Productivity Scripts:"
            echo "  1) Count lines of code"
            echo "  2) Create timestamped backup"
            echo "  3) Extract .tar.gz files"
            echo "  4) Show disk usage sorted by size"
            echo "  5) Find TODO/FIXME in code files"
            echo ""
            read -p "Select productivity script (1-5): " sub_choice
            case $sub_choice in
                1|2|4|5)
                    "$SCRIPTS_DIR/productivity_scripts.sh" "$sub_choice"
                    ;;
                2)
                    read -p "Enter filename to backup: " filename
                    "$SCRIPTS_DIR/productivity_scripts.sh" 2 "$filename"
                    ;;
                3)
                    "$SCRIPTS_DIR/productivity_scripts.sh" 3
                    ;;
                *)
                    echo "Invalid option. Please select 1-5."
                    ;;
            esac
            ;;
        3)
            echo ""
            read -p "Enter interval in seconds (default 2): " interval
            interval=${interval:-2}
            read -p "Enter command to watch: " command
            "$SCRIPTS_DIR/simple_watch.sh" "$interval" "$command"
            ;;
        4)
            echo ""
            echo "Bash Cheatsheet (first 20 lines):"
            head -n 20 "$LIB_DIR/bash_cheatsheet.md"
            echo ""
            read -p "Press Enter to continue..."
            ;;
        5)
            echo ""
            show_menu
            ;;
        0)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please select 0-5."
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
    clear
    show_menu
done