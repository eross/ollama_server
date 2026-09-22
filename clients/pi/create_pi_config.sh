#!/bin/bash

# CLI program to retrieve all current Ollama models and save to JSON

OLLAMA_HOST="${OLLAMA_HOST:-http://localhost:11434}"

HOST_FILE="/tmp/ollama_host_$$"
echo "$OLLAMA_HOST" > "$HOST_FILE"

# Transform all models into array, then wrap with providers object (pretty-printed output)
curl -s "$OLLAMA_HOST/api/tags" | jq -c --arg arghost "$(cat $HOST_FILE)" '.models[]' | jq -c '{id: .model, name: (.name // .model), reasoning: false, contextWindow: (.details.context_length // 131072), maxTokens: (.details.context_length // 131072), input: ["text"], samplingParams: {temperature: 1.0, top_p: 0.95, top_k: 64}}' | jq -s --arg baseUrl "$(cat $HOST_FILE)/v1" '{providers: {ollama: {baseUrl: $baseUrl, api: "openai-completions", apiKey: "ollama", think: false, compat: {supportsDeveloperRole: false, supportsReasoningEffort: false}, models: .}}}'

rm -f "$HOST_FILE"
