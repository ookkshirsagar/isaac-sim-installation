# 🚀 NVIDIA Isaac Sim Setup (Docker + Native)

This repository provides an automated way to prepare your Ubuntu system for **NVIDIA Isaac Sim**. It handles driver verification, Docker containerization support, and native dependency installation.

---

## 📋 Prerequisites
- **OS:** Ubuntu 22.04 or 20.04
- **GPU:** NVIDIA RTX (Recommended: RTX 30-series or higher)
- **Display:** Must be using an **X11** session (Wayland is not supported by Isaac GUI)

---

## 🧩 1. Quick Start
Clone this repository and run the setup script:

\`\`\`bash
# 1. Make the script executable
chmod +x setup_isaac.sh

# 2. Run the automation
./setup_isaac.sh
\`\`\`

---

## ⚙️ 2. What the script does
1. **Verifies GPU:** Checks for NVIDIA drivers and CUDA compatibility.
2. **Installs Docker:** Sets up the Docker engine.
3. **NVIDIA Container Toolkit:** Configures the runtime so Docker can access your GPU.
4. **Native Dependencies:** Installs the required Linux libraries (\`libglu1\`, \`mesa-utils\`, etc.) needed to run Isaac Sim outside of Docker.
5. **Prepares Workspace:** Creates the \`~/apps/isaac-sim\` directory for your installation.

---

## 🖥️ 3. Finalizing Native Installation
The script prepares the system, but you must manually download the Isaac Sim package from the **NVIDIA Developer Portal**:

1. Download the Isaac Sim \`.zip\` or \`.tar.gz\`.
2. Move it to \`~/apps/isaac-sim\`.
3. Unzip the contents:
   \`\`\`bash
   cd ~/apps/isaac-sim
   unzip isaac-sim-*.zip
   \`\`\`
4. Launch Isaac Sim:
   \`\`\`bash
   ./isaac-sim.sh
   \`\`\`

---

## ⚡ 4. Useful Commands
After running the script, you can use the **alias** (after running \`source ~/.bashrc\`):
- \`isaac\`: Quickly jump to the directory and launch the simulator.

---

## ✅ Verification
- Run \`nvidia-smi\` to ensure the GPU is active.
- Run \`docker run --rm --gpus all nvidia/cuda:12.0.0-base-ubuntu22.04 nvidia-smi\` to verify Docker GPU access.
