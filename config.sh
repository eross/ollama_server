ollama pull gpt-oss:20b
ollama pull qwen3:14b
ollama pull deepseek-r1:14b
ollama pull deepseek-r1:8b
ollama pull qwen3b-coder:32b
ollama pull qwen3b-coder:30b
ollama pull qwen3:32b
ollama pull gemma4:26b
ollama pull gpt-oss:120b
ollama pull devstral-small-2:24b




ollama create qwen30b-coder-dev -f ./models/Modelfile.qwen-code30b
ollama create qwen32b-coder-dev -f ./models/Modelfile.qwen-code32b
ollama cp gpt-oss:20b default

