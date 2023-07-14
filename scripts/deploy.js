const { ethers } = require("hardhat");

async function main() {

  const Wallet2 = await ethers.deployContract("Wallet2");
  Wallet2.waitForDeployment();

  const [deployer] = await ethers.getSigners();
  const Wallet2Address = await Wallet2.getAddress();

  console.log(" ");
  console.log("Wallet2 address: ",Wallet2Address);
  console.log(" ");
  console.log("-------------------------------------------------------------------");
  console.log(" ");
  console.log("Deploying contracts with the account:", deployer.address);
  console.log(" ");
}



main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});