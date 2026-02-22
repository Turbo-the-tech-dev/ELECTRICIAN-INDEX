#!/bin/bash
# ==============================================================================
# ELECTRICIAN-INDEX Maintenance Dashboard
# ==============================================================================

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
NC="\033[0m"

echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}       ELECTRICIAN-INDEX Maintenance Dashboard          ${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""

# 1. Repository Health & Stats
echo -e "${YELLOW}[1] Repository Health - Top 10 Most Active Files:${NC}"
git log --pretty=format: --name-only 2>/dev/null | sort | uniq -c | sort -rg | head -10 || echo "  Git not initialized"
echo ""

# 2. TODO/FIXME Hunter
echo -e "${YELLOW}[2] TODO/FIXME Items:${NC}"
grep -rnE "TODO|FIXME" . --exclude-dir=node_modules --exclude-dir=.git 2>/dev/null | head -10 || echo "  None found"
echo ""

# 3. Index Entry Counter
echo -e "${YELLOW}[3] Markdown Index Count:${NC}"
MD_COUNT=$(find . -name "*.md" -not -path "./node_modules/*" 2>/dev/null | wc -l)
echo -e "  ${GREEN}$MD_COUNT${NC} markdown files found"
echo ""

# 4. Search Hardcoded Values in SRS
echo -e "${YELLOW}[4] Hardcoded Numbers in src/ (potential magic numbers):${NC}"
grep -rE "[0-9]{2,}" src/ --exclude="*.test.ts" 2>/dev/null | head -5 || echo "  None found"
echo ""

# 5. Git Status
echo -e "${YELLOW}[5] Git Status:${NC}"
git status --short 2>/dev/null || echo "  Git not initialized"
echo ""

# 6. File Structure
echo -e "${YELLOW}[6] Project Structure:${NC}"
find . -maxdepth 3 -type f -name "*.ts" -o -name "*.json" -o -name "*.md" 2>/dev/null | grep -v node_modules | head -15
echo ""

echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Maintenance check complete!${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
