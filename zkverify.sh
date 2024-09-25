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
show "Installing Rust..."
echo
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
export RUSTUP_HOME="$HOME/.rustup"
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"
sleep 3
source ~/.bashrc


echo
show "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
sleep 2


export NVM_DIR="/usr/local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.bashrc


echo
show "Installing Node.js..."
echo
nvm install node
nvm use node
nvm alias default node


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
echo
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
node snarkjs2zkv convert-proof /workspaces/codespaces-blank/zkverify-proofverification/proof.json -o proof_zkv.json
node snarkjs2zkv convert-vk /workspaces/codespaces-blank/zkverify-proofverification/verification_key.json -o verification_key_zkv.json
node snarkjs2zkv convert-public /workspaces/codespaces-blank/zkverify-proofverification/public.json -o public_zkv.json -c bn128
echo
