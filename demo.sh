#!/bin/bash
# Example script demonstrating how to use the bash utils library

echo "=== Bash Utils Library Examples ==="
echo ""

echo "1. Checking disk usage:"
echo "   Running: ./scripts/dev_utils.sh 1"
../scripts/dev_utils.sh 1 | head -10
echo ""

echo "2. Finding largest files:"
echo "   Running: ./scripts/dev_utils.sh 5 | head -5"
../scripts/dev_utils.sh 5 | head -5
echo ""

echo "3. Counting lines of code in this library:"
echo "   Running: ./scripts/productivity_scripts.sh 1"
../scripts/productivity_scripts.sh 1
echo ""

echo "For more options, run: ./bash-utils.sh"