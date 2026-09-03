./import.sh
ollama create qwen30b-coder-dev -f ./models/Modelfile.qwen-code30b
ollama create qwen32b-dev -f ./models/Modelfile.qwen3-32b
ollama cp gpt-oss:20b default
