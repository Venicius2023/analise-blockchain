#!/bin/bash

# URL da API do Ethereum para informações sobre o bloco
ETH_API_URL="https://api.etherscan.io/api?module=proxy&action=eth_getBlockByNumber&tag=latest&boolean=true"

# Realiza a consulta à API
BLOCK_INFO=$(curl -s "${ETH_API_URL}")

# Verifica se a consulta foi bem-sucedida
if [[ "$BLOCK_INFO" =~ "\"result\":{".*\"transactions\":\[.*\],\"number\":\"([0-9A-Fa-f]+)\".*\"parentHash\":\"([0-9A-Fa-f]+)\".*" ]]; then
  # Extrai as informações relevantes
  LATEST_BLOCK_NUMBER="${BASH_REMATCH[1]}"
  PARENT_HASH="${BASH_REMATCH[2]}"
  
  # Conta o número de transações no bloco mais recente
  NUM_TRANSACTIONS=$(echo "$BLOCK_INFO" | jq '.result.transactions | length')
  
  echo "Informações do bloco mais recente:"
  echo "Número do Bloco: ${LATEST_BLOCK_NUMBER}"
  echo "Hash Anterior: ${PARENT_HASH}"
  echo "Número de Transações: ${NUM_TRANSACTIONS}"
else
  echo "Erro ao consultar informações do bloco mais recente."
fi
