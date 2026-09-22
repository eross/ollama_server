#!/bin/bash

# Check OLLAMA_HOST is set
if [ -z "${OLLAMA_HOST}" ]; then
  echo "Error: OLLAMA_HOST environment variable not set" >&2
  exit 1
fi

# Fetch models from Ollama API and generate config
curl -s "${OLLAMA_HOST}/api/tags" | \
jq --arg baseUrl "${OLLAMA_HOST}/v1" '
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (local)",
      "options": {
        "baseURL": $baseUrl,
        "apiKey": "ollama"
      },
      "models": ([.models[] | {key: (.name), value: {
        name: ((.name | split(":"))[0] + ":") + (.name | split(":"))[1],
        reasoning: false,
        limit: {
          context: 131072,
          output: 131072
        },
        options: {
          temperature: 1.0,
          top_p: 0.95,
          top_k: 64
        }
      }}] | from_entries)
    }
  }
}'
