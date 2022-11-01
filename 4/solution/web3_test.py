from web3 import Web3, HTTPProvider

rpc = 'https://sepolia.infura.io/v3/'
web3 = Web3(HTTPProvider(rpc))

print(web3.is_connected())