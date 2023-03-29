const HDWalletProvider = require('@truffle/hdwallet-provider')
require("dotenv").config({path:'./.env' })
const privateKey = process.env.PRIVATE_KEY

module.exports = {
  networks: {
    matic_testnet: {
      provider: () => new HDWalletProvider(privateKey, 'https://polygon-mumbai.g.alchemy.com/v2/dpDZ_v-uHpEHo2ENTR-KT5SnVmJw3h4X'), // wss://speedy-nodes-nyc.moralis.io/af271fa0290d1b4fdf0a5b35/polygon/mumbai/ws
      network_id: 80001,
      skipDryRun: true
    },
    
    matic_mainnet: {
      provider: () => {
        return new HDWalletProvider(mnemonic, "https://rpc-mainnet.maticvigil.com/");
      },
      network_id: 137,
      gasPrice: 122000000000,
      skipDryRun: true
    },
    goerli: {
      provider: () => {
        return new HDWalletProvider(privateKey, "wss://eth-goerli.g.alchemy.com/v2/mP5M97XSz2PH983Y9DKuGTcKwytpzHuk")
      },
      network_id: 5,
      // gasPrice: 10000000000,
      skipDryRun: true
    },
    mainnet: {
      provider: () => {
        return new HDWalletProvider(pk, "wss://mainnet.infura.io/ws/v3/66566fe75bcd493baa674d8a26a42566")
      },
      gasPrice: 122000000000,
      network_id: '1',
      skipDryRun: true
    },
  },
  compilers: {
    solc: {
      version: '0.8.16',
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        },
      evmVersion: "petersburg"  
      }
    }
  },
  api_keys:{
    etherscan: process.env.API_KEY
  },
  plugins : [
    'truffle-plugin-verify'
  ]
}
