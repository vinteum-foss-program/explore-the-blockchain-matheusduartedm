# Which tx in block 257,343 spends the coinbase output of block 256,128?
#!/bin/bash

coinbase_txid=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 256128) | jq -r '.tx[0]')

txids=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 257343) | jq -r '.tx[]')

for txid in $txids; do
    vin_txids=$(bitcoin-cli getrawtransaction $txid true | jq -r '.vin[].txid')
    for vin_txid in $vin_txids; do
        if [ "$vin_txid" == "$coinbase_txid" ]; then
            echo $txid
            exit 0
        fi
    done
done
