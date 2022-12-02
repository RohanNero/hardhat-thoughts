const { network, ethers } = require("hardhat")
const { networkConfig, developmentChains } = require("../helper-hardhat-config")

module.exports = async function ({ deployments, getNamedAccounts }) {
  const { deploy, log } = deployments
  const { deployer } = await getNamedAccounts()
  //console.log(deployer)
  const simpleThoughts = await deploy("SimpleThoughts", {
    from: deployer,
    args: deployer.address,
    log: true,
    waitConfirmations: network.config.blockConfirmations || 1,
  })
}

module.exports.tags = ["all", "main", "simple"]
