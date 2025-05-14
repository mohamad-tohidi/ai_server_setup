#!/usr/bin/env sh
# Enhanced Miniconda installer with progress indicators

set -e

INSTALL_DIR="$HOME/miniconda3"
INSTALLER="/tmp/miniconda.sh"
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

print_stage() {
    echo ""
    echo "=============================="
    echo "$1"
    echo "=============================="
}

# 1. Download installer with progress bar
print_stage "1. Downloading Miniconda installer..."
curl --progress-bar -L "$MINICONDA_URL" -o "$INSTALLER"

# 2. Install Miniconda silently
print_stage "2. Installing Miniconda to $INSTALL_DIR..."
bash "$INSTALLER" -b -p "$INSTALL_DIR"

# 3. Clean up
print_stage "3. Cleaning up installer..."
rm -f "$INSTALLER"

# 4. Initialize conda
print_stage "4. Initializing Conda for your shell..."
"$INSTALL_DIR/bin/conda" init

# 5. Done
print_stage "✅ Installation complete!"
echo "Restart your shell or run: exec \$SHELL"
echo "Then try: conda activate base"
