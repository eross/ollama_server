# script for installing all my favorite models.

export OLAMA_HOST="${OLAMA_HOST:-0.0.0.0:1143}"
# For wsl2 use 172.xx.xx.xx
# Use the netstat -rn returned gateway address (usually ends in 0.1)
ollama pull devstral-small-2:24b
ollama pull gemma4:26b
ollama pull gpt-oss:20b
ollama pull llama3.1:8b
ollama pull qwen3.5:9b
ollama pull qwen3.5:4b
ollama pull qwen3.5:2b
ollama pull qwen3:8b
ollama pull qwen3:14b
ollama pull qwen3:4b
ollama pull mistral

ollama pull hf.co/nvidia/NVIDIA-Nemotron-3-Nano-4B-GGUF:Q4_K_M
ollama cp hf.co/nvidia/NVIDIA-Nemotron-3-Nano-4B-GGUF:Q4_K_M nemotron
ollama pull hf.co/unsloth/gemma-4-26B-A4B-it-GGUF:UD-IQ2_M
ollama cp hf.co/unsloth/gemma-4-26B-A4B-it-GGUF:UD-IQ2_M gemma-4M:26b
ollama pull hf.co/unsloth/gemma-4-26B-A4B-it-GGUF:UD-IQ2_XXS
ollama cp hf.co/unsloth/gemma-4-26B-A4B-it-GGUF:UD-IQ2_XXS gemma-4XXS:26b

ollama create -f models/qwen3-coder.model qwen3-coder-30b:q2_k_m



