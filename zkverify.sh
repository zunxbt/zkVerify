#!/bin/bash

curl -s https://raw.githubusercontent.com/zunxbt/logo/main/logo.sh | bash
sleep 3

show() {
    echo -e "\033[1;34m$1\033[0m"
}

show "Updating package list and installing Git..."
echo
sudo apt update
sudo apt install -y git
echo
show "Installing Node.js..."
wget -O - https://raw.githubusercontent.com/zunxbt/installation/main/node.sh | bash
echo
show "Cloning zkverify-proofverification repository..."
echo
git clone https://github.com/0xmetaschool/zkverify-proofverification.git
cd zkverify-proofverification
echo
show "Installing snarkjs..."
echo
npm install -g snarkjs@latest


echo
show "Cloning circom repository..."
echo
git clone https://github.com/iden3/circom.git
cd circom


echo
show "Installing circom..."
source <(wget -O - https://raw.githubusercontent.com/zunxbt/installation/main/rust.sh)
cargo install --path circom
cd ..

show "Setting up circuits..."
echo
sudo chmod +x circuit_setup.sh
./circuit_setup.sh


show "Cloning snarkjs2zkv repository..."
echo
git clone https://github.com/HorizenLabs/snarkjs2zkv.git
cd snarkjs2zkv

show "Installing snarkjs2zkv..."
echo
npm install

show "Converting proof and verification keys..."
node ../snarkjs2zkv convert-proof ../proof.json -o ../proof_zkv.json && \
node ../snarkjs2zkv convert-vk ../verification_key.json -o ../verification_key_zkv.json && \
node ../snarkjs2zkv convert-public ../public.json -o ../public_zkv.json -c bn128
echo
