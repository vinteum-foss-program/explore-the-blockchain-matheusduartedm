# How many new outputs were created by block 123,456?
#!/bin/bash
blockhash=$(bitcoin-cli getblockhash 123456)
block=$(bitcoin-cli getblock $blockhash 2)
echo "$block" | jq '[.tx[].vout[]] | length'
