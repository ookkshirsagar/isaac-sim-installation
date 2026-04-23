#!/bin/bash

# =================================================================
# NVIDIA Isaac Sim Automated Setup Script
# =================================================================

echo "🚀 Starting NVIDIA Isaac Sim Setup..."

# 1. Verify NVIDIA GPU
echo "🧩 Checking GPU and Drivers..."
lspci | grep -i nvidia
nvidia-smi
if [ $? -ne 0 ]; then
    echo "❌ NVIDIA Drivers not found. Please install drivers before running this script."
    exit 1
fi

echo "🖥️ Checking Display Session..."
echo "Session Type: $XDG_SESSION_TYPE"
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    echo "⚠️ Warning: You are on Wayland. Isaac Sim requires X11 for the GUI to work properly."
fi

# 2. Install Docker
echo "🐳 Installing Docker..."
sudo apt update
sudo apt install docker.io -y
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# 3. Install NVIDIA Container Toolkit
echo "⚙️ Installing NVIDIA Container Toolkit..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/deb/amd64 /" | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update
sudo apt install -y nvidia-container-toolkit

echo "🔄 Configuring Docker Runtime..."
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# 4. Install Native Dependencies
echo "🖥️ Installing Native Dependencies..."
sudo apt install -y \
libglu1-mesa libxi6 libxmu6 libxrandr2 libxinerama1 libxcursor1 \
libxcomposite1 libasound2t64 libnss3 libxtst6 mesa-utils unzip

# 5. Prepare Directories
echo "📁 Preparing Folders..."
mkdir -p ~/apps/isaac-sim
echo "✅ Folder created at ~/apps/isaac-sim"

# 6. Create Alias
if ! grep -q "alias isaac=" ~/.bashrc; then
    echo "⚡ Adding 'isaac' alias to ~/.bashrc..."
    echo "alias isaac='cd ~/apps/isaac-sim && ./isaac-sim.sh'" >> ~/.bashrc
    echo "✅ Alias added. Note: You will need to run 'source ~/.bashrc' after this script finishes."
fi

echo "--------------------------------------------------------"
echo "✅ Setup Script Finished!"
echo "1. If you have the Isaac Sim zip file, move it to ~/apps/isaac-sim and unzip it."
echo "2. Run: source ~/.bashrc"
echo "3. Run: isaac (after unzipping)"
echo "--------------------------------------------------------"
