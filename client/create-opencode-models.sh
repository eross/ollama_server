#!/bin/bash

# Generate opencode-compatible JSON file with all Ollama models
# Usage: list-opencode-models.sh
# Environment variable: OLLAMA_HOST (optional, defaults to http://localhost:11434)

BASE_URL="${OLLAMA_HOST:-http://localhost:11434}"
models_json=""

while IFS= read -r line; do
    model_name=$(echo "$line" | awk '{print $1}')
    if [ -n "$model_name" ]; then
        name=$(echo "$model_name" | sed 's/^[^:]*://')
        models_json="${models_json}      \"$model_name\": {
          \"name\": \"$name\",
          \"reasoning\": false,
          \"limit\": {
            \"context\": 131072,
            \"output\": 131072
          },
          \"options\": {
            \"temperature\": 1.0,
            \"top_p\": 0.95,
            \"top_k\": 64
          }
        },"
    fi
done <<< "$(ollama ls 2>/dev/null)"

echo '{'
echo '  "$schema": "https://opencode.ai/config.json",'
echo '  "provider": {'
echo '    "ollama": {'
echo "      \"npm\": \"@ai-sdk/openai-compatible\","
echo '      "name": "Ollama (local)",'
echo "      \"options\": {"
printf '        "baseURL": "%s/v1",' "$BASE_URL"
echo '        "apiKey": "ollama",'
echo '      },'
printf '%s' "${models_json%,}"
echo ''
echo '      }'
echo '    }'
echo '  }'
echo '}'
