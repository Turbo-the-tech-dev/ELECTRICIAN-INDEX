# Bash Command Cheatsheet for Developers

## 📁 File & Directory Operations
```bash
ls -la                   # List all files (including hidden) with details
ls -ltr                  # List sorted by time (oldest last)
pwd                      # Print current directory
cd -                     # Go to previous directory
mkdir -p path/to/dir     # Create parent directories as needed
rm -rf dir/              # Remove directory and contents (careful!)
cp -rv source/ dest/     # Copy recursively with verbose
mv file1 file2           # Move/rename
find . -name "*.py"      # Find files by name
find . -type f -size +10M # Find files larger than 10MB
tree -L 2                # Show directory tree (install tree)
du -sh * | sort -h       # Disk usage per item, sorted
ln -s target link        # Create symbolic link
```

## 📝 Text Processing & Viewing
```bash
cat file.txt             # Print entire file
less file.txt            # Scroll through file (q to quit)
head -n 20 file.txt      # First 20 lines
tail -f logfile          # Follow a growing log
grep "error" *.log       # Search for pattern
grep -r "TODO" .         # Recursive search
grep -l "main" *.py      # List files containing pattern
sed -i 's/old/new/g' file # Replace in-place
awk '{print $1}' file    # Print first column
cut -d',' -f1,3 file.csv # Cut columns from CSV
wc -l file.txt           # Count lines
sort file.txt | uniq -c  # Count unique lines
diff file1 file2         # Show differences
```

## 🔧 Permissions & Ownership
```bash
chmod +x script.sh       # Make executable
chmod 644 file           # rw-r--r-- (owner read/write, group/others read)
chmod 755 dir            # rwxr-xr-x for directories
chown user:group file    # Change owner/group
umask                    # Show default permissions mask
```

## 🧹 Cleanup & Maintenance
```bash
find . -name "__pycache__" -type d -exec rm -rf {} +
find . -name "*.pyc" -delete
find . -type f -name "*.log" -mtime +7 -delete   # Delete logs older than 7 days
df -h                    # Disk free space
du -sh ~/Projects        # Size of a directory
```

## 🌐 Networking
```bash
ping google.com          # Check connectivity
curl ifconfig.me         # Get public IP
curl -I https://site.com # Fetch HTTP headers
wget -r -l2 -np URL      # Recursive download (2 levels)
netstat -tulpn           # Listening ports (Linux)
ss -tulpn                # Modern alternative
ssh user@host            # Connect to remote
scp file user@host:/path # Copy over SSH
rsync -avz source/ dest/ # Sync files (local or remote)
```

## 🐙 Git Commands
```bash
git status               # What's changed
git add -p               # Interactively stage hunks
git commit --amend       # Fix last commit message
git log --oneline --graph # Pretty history
git diff --staged        # Show staged changes
git checkout -b feature  # Create and switch branch
git branch -d branch     # Delete local branch
git push origin --delete branch # Delete remote branch
git stash                # Temporarily save changes
git stash pop            # Restore stashed changes
git rebase -i HEAD~5     # Interactive rebase last 5 commits
git cherry-pick <hash>   # Apply a specific commit
git remote -v            # Show remotes
git fetch --prune        # Remove stale remote branches
git bisect start         # Binary search for bug
```

## 🐍 Python Environment
```bash
python3 -m venv venv     # Create virtual environment
source venv/bin/activate # Activate it
pip freeze > requirements.txt # Save dependencies
pip install -r requirements.txt # Install from file
pip list --outdated      # Show outdated packages
python -m pip install --upgrade pip # Upgrade pip
python -m http.server 8000 # Start simple HTTP server
python -c "import json; print(json.dumps({'a':1}))" # One-liner
```

## ⚙️ Process Management
```bash
ps aux | grep python     # Find Python processes
htop                     # Interactive process viewer (install)
top                      # Basic process viewer
kill -9 PID              # Force kill
killall python           # Kill all Python processes
nohup ./script.sh &      # Run in background, survive logout
jobs                     # List background jobs
fg %1                    # Bring job 1 to foreground
```

## 🗜️ Compression & Archiving
```bash
tar -czf archive.tar.gz dir/   # Create tar.gz
tar -xzf archive.tar.gz        # Extract tar.gz
tar -cjf archive.tar.bz2 dir/  # tar.bz2
tar -xjf archive.tar.bz2       # Extract bz2
zip -r archive.zip dir/        # Create zip
unzip archive.zip              # Extract zip
gzip file                      # Compress single file
gunzip file.gz                 # Decompress
```

## 🔍 Searching
```bash
find . -name "*.html" -exec grep -l "TODO" {} \;  # Find HTML files containing TODO
grep -rn "function" --include="*.js" .             # Recursive search in JS files
which python3               # Show path of an executable
whereis bash                # Locate binaries, man pages
locate filename             # Fast database search (needs updatedb)
```

## 🔐 Security & Permissions
```bash
ssh-keygen -t ed25519      # Generate SSH key
ssh-copy-id user@host      # Copy public key to server
chmod 600 ~/.ssh/id_ed25519 # Private key must be secure
gpg -c file                 # Symmetric encrypt file
gpg file.gpg                # Decrypt
```

## ⏰ Cron & Scheduling
```bash
crontab -l                  # List cron jobs
crontab -e                  # Edit cron jobs
# Example: 0 2 * * * /home/user/backup.sh  # Run at 2am daily
at 10:00                    # Schedule one-time task (install at)
```

## 🧪 Debugging & System Info
```bash
dmesg | tail                # Kernel messages
journalctl -xe              # Systemd logs
free -h                     # Memory usage
uname -a                    # Kernel info
cat /etc/os-release         # OS version
lscpu                       # CPU info
lsblk                       # Block devices
```

## 🧩 Aliases & Bash Customisation
```bash
alias ll='ls -la'
alias gs='git status'
alias gp='git push'
alias ..='cd ..'
echo "alias ll='ls -la'" >> ~/.bashrc
source ~/.bashrc
```

## 🧮 One‑liners for Everyday Magic
```bash
# Count lines of code (excluding empty lines, comments)
find . -name "*.py" -not -path "*/venv/*" | xargs cat | grep -v "^\s*$" | grep -v "^\s*#" | wc -l

# Watch a command every 2 seconds
watch -n 2 'ls -l'

# Create a timestamped backup of a file
cp important.txt{,.$(date +%Y%m%d_%H%M%S)}

# Monitor CPU temperature (if available)
watch -n 1 'cat /sys/class/thermal/thermal_zone*/temp'

# Extract all .tar.gz files in a folder
for f in *.tar.gz; do tar -xzf "$f"; done

# Parallel execution (replace with parallel if installed)
echo "cmd1; cmd2" | tr ';' '\n' | xargs -P 2 -I {} sh -c "{}"
```

## 📦 Package Management (Debian/Ubuntu)
```bash
sudo apt update               # Update package lists
sudo apt upgrade              # Upgrade all packages
sudo apt install package      # Install
sudo apt remove package       # Remove
apt search keyword            # Search packages
dpkg -l | grep package        # List installed
```

## 🐳 Docker (if you use containers)
```bash
docker ps                     # List running containers
docker images                 # List images
docker build -t name .        # Build image
docker run -it name /bin/bash # Run container interactively
docker-compose up -d          # Start services in background
docker system prune -f        # Clean up unused
```

## 🧠 Bonus: Best Practices

· Always use version control.
· Never run rm -rf / (yes, it happens).
· Backup before bulk operations.
· Use man (e.g., man grep) to learn more.
· Write scripts for repetitive tasks.
· Use set -e in shell scripts to exit on error.
· Keep your dotfiles in a repo.