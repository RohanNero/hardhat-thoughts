require("@nomiclabs/hardhat-etherscan")
require("@nomicfoundation/hardhat-chai-matchers")
require("@nomiclabs/hardhat-ethers")
require("dotenv").config()
require("hardhat-contract-sizer")
require("hardhat-gas-reporter")
require("prettier")
require("prettier-plugin-solidity")
require("solidity-coverage")

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
}
