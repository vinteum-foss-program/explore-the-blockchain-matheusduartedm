# Only one single output remains unspent from block 123,321. What address was it sent to?
#!/bin/bash

block_hash=$(bitcoin-cli getblockhash 123321)

txids=$(bitcoin-cli getblock $block_hash | jq -r '.tx[]')

for txid in $txids; do
    decoded_tx=$(bitcoin-cli getrawtransaction $txid true)
    vout_indices=$(echo $decoded_tx | jq '.vout[].n')
    for vout in $vout_indices; do
        utxo=$(bitcoin-cli gettxout $txid $vout)
        if [ -n "$utxo" ]; then
            address=$(echo $utxo | jq -r '.scriptPubKey.address')
            echo $address
            exit 0
        fi
    done
done
