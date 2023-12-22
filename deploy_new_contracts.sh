#!/bin/bash

set -e

# get network as the first command line argument
network=$1

echo "Cleaning the artifacts directory..."
npx hardhat clean

echo "Compiling contracts..."
npx hardhat compile

echo "Deploying contracts to the $network network..."
npx hardhat run scripts/deploy.js --network $network

echo "Uploading the new contract ABIs to Google Drive..."
python3 upload_new_contract_abis.py