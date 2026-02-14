# Bash Utils Library

A collection of useful Bash utilities and scripts for developers. This library provides commonly used commands and scripts organized by category for easy access and reuse.

## 📁 Structure

```
bash-utils/
├── scripts/           # Executable scripts
│   ├── dev_utils.sh      # Development utilities
│   ├── productivity_scripts.sh  # Productivity tools
│   └── simple_watch.sh   # Simple watch implementation
├── docs/              # Documentation
│   └── README.md         # This file
├── examples/          # Usage examples
└── bash_cheatsheet.md # Comprehensive command reference
```

## 🚀 Getting Started

### Prerequisites

- Bash shell
- Unix-like environment (Linux, macOS, WSL, Termux)

### Installation

Clone or copy this library to your preferred location:

```bash
# Clone to your home directory
git clone https://github.com/username/bash-utils.git ~/lib/bash-utils
# Or copy from your local directory
cp -r /path/to/bash-utils ~/lib/
```

### Setup

Make all scripts executable:

```bash
chmod +x ~/lib/bash-utils/scripts/*.sh
```

Add to your PATH (optional):

```bash
echo 'export PATH="$PATH:$HOME/lib/bash-utils/scripts"' >> ~/.bashrc
source ~/.bashrc
```

## 🛠️ Available Scripts

### dev_utils.sh

Development utilities for common tasks:

```bash
# Disk usage by directory
./dev_utils.sh 1

# Clean Python cache files
./dev_utils.sh 2

# List running Python processes
./dev_utils.sh 3

# Show directory tree (if tree is installed)
./dev_utils.sh 4

# Find largest files
./dev_utils.sh 5

# Backup Projects folder
./dev_utils.sh 6
```

### productivity_scripts.sh

Productivity tools for common development tasks:

```bash
# Count lines of code (excluding empty lines and comments)
./productivity_scripts.sh 1

# Create timestamped backup of a file
./productivity_scripts.sh 2 filename.txt

# Extract all .tar.gz files in current directory
./productivity_scripts.sh 3

# Show disk usage sorted by size
./productivity_scripts.sh 4

# Find TODO/FIXME in code files
./productivity_scripts.sh 5
```

### simple_watch.sh

Simple implementation of the watch command:

```bash
# Run ls -l every 2 seconds (default)
./simple_watch.sh ls -l

# Run with custom interval (5 seconds)
./simple_watch.sh 5 ls -l
```

## 📚 Additional Resources

- `bash_cheatsheet.md` - Comprehensive reference of useful Bash commands
- `docs/` - Detailed documentation for each script
- `examples/` - Usage examples for common scenarios

## 🤝 Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue.

## 📄 License

MIT License - feel free to use and modify as needed.