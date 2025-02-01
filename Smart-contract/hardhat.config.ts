import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config()

const {LISK_SEPOLIA_API_KEY, ACCOUNT_PRIVATE_KEY, ETHERSCAN_API_KEY} = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.28",

  networks: {
    lisk: {
      url:LISK_SEPOLIA_API_KEY,
      accounts: [`0x${ACCOUNT_PRIVATE_KEY}`]
    }
},
etherscan: {
  apiKey: ETHERSCAN_API_KEY,
     
} 
};

export default config;
