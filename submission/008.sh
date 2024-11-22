# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
#!/bin/bash

txid="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

raw_tx_hex=$(bitcoin-cli getrawtransaction $txid)

decoded_tx=$(bitcoin-cli decoderawtransaction "$raw_tx_hex")

txinwitness=$(echo "$decoded_tx" | jq '.vin[0].txinwitness')

witness_count=$(echo "$txinwitness" | jq 'length')

if [ "$witness_count" -ge 3 ]; then
    witness_script=$(echo "$decoded_tx" | jq -r '.vin[0].txinwitness[2]')
    
    decoded_witness_script=$(bitcoin-cli decodescript "$witness_script")
    
    pubkey=$(echo "$decoded_witness_script" | jq -r '.asm' | cut -d' ' -f2)
    
    echo "$pubkey"
fi
