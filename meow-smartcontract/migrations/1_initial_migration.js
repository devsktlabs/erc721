const { upgradeProxy, deployProxy } = require('@openzeppelin/truffle-upgrades');

// // ############# 1st deployment  ####################


// const myContract = artifacts.require("JustSalV1");
// // 4bdff9c5cb8e284e2d9cfef226a8d2e9eafc7f54c73265854c8ef3e53be72359
// module.exports = async function (deployer) {
//   const instance = await deployProxy(myContract, { deployer });
//   console.log('Deployed', instance.address);
// };

// ############# upgrade deployment  ####################

const oldContract = artifacts.require('JustSalV1');
const newContract = artifacts.require('JustSalV2');

module.exports = async function (deployer) {
  const existing = await oldContract.deployed();
  const instance = await upgradeProxy(existing.address, newContract, { deployer });
  console.log("Upgraded", instance.address);
};