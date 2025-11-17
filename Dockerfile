# ======================================================================
# Base image: PyTorch with CUDA 12.1 (compatible with IndexTTS2)
# ======================================================================
FROM pytorch/pytorch:2.2.0-cuda12.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive
ENV HF_ENDPOINT="https://hf-mirror.com"

# ======================================================================
# Install system dependencies
# ======================================================================
RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    curl \
    build-essential \
    ffmpeg \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Enable Git LFS
RUN git lfs install

# ======================================================================
# Install uv (official supported method inside container) 
# ======================================================================
RUN pip install -U uv

# ======================================================================
# Clone IndexTTS2 repository
# ======================================================================
WORKDIR /app
RUN git clone https://github.com/index-tts/index-tts.git
WORKDIR /app/index-tts

# Pull LFS files (small but required)
RUN git lfs pull

# ======================================================================
# Install Python dependencies using uv
# ======================================================================
RUN uv sync --all-extras

# ======================================================================
# Install HuggingFace CLI for model downloads
# ======================================================================
RUN uv tool install "huggingface-hub[hf_xet]"

# Add uv tools to PATH so "hf" becomes available
# ENV PATH="/root/.local/share/uv/tools/bin:${PATH}"

# Create checkpoint folder
RUN mkdir -p /app/index-tts/checkpoints

# ======================================================================
# Download IndexTTS2 model
# ======================================================================
#RUN hf download IndexTeam/IndexTTS-2 --local-dir=/app/index-tts/checkpoints
RUN /root/.local/bin/hf download IndexTeam/IndexTTS-2 --local-dir=/app/index-tts/checkpoints

# ======================================================================
# Expose WebUI port
# ======================================================================
EXPOSE 7860

# ======================================================================
# Default command: Launch the WebUI
# ======================================================================
CMD ["uv", "run", "webui.py", "--host", "0.0.0.0", "--port", "7860"]
