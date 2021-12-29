#!/bin/bash

# Usage ./hash_cert.sh domain.com:port
# Example ./hash_cert.sh google.com:443

file=$(mktemp)

openssl s_client -connect $1 -showcerts 2>/dev/null </dev/null | awk '/-BEGIN CERTIFICATE-/{p=1} p; /-END CERTIFICATE/{exit}' > $file
openssl x509 -noout -in $file -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64

rm $file
