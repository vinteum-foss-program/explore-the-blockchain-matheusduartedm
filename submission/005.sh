# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
#!/bin/bash

raw=$(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517)

decoded=$(bitcoin-cli decoderawtransaction $raw)

bitcoin-cli createmultisig 1 '[
  "'$(echo $decoded | jq -r '.vin[0].txinwitness[1]')'",
  "'$(echo $decoded | jq -r '.vin[1].txinwitness[1]')'",
  "'$(echo $decoded | jq -r '.vin[2].txinwitness[1]')'",
  "'$(echo $decoded | jq -r '.vin[3].txinwitness[1]')'"
]' "legacy" | jq -r '.address'
