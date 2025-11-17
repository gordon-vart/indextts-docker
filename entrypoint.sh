#!/bin/bash
set -e

# Download model if checkpoints folder is empty
if [ ! -f /app/index-tts/checkpoints/config.json ]; then
    echo "Checkpoints folder empty. Downloading IndexTTS model..."
    /root/.local/bin/hf download IndexTeam/IndexTTS-2 --local-dir /app/index-tts/checkpoints
else
    echo "Checkpoints folder already contains the model. Skipping download."
fi

# Launch WebUI
uv run webui.py --host 0.0.0.0 --port 7860
