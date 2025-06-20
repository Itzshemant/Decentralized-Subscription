const hre = require("hardhat");

async function main() {
  const fee = hre.ethers.utils.parseEther("0.01"); // 0.01 ETH subscription fee
  const ContentSubscription = await hre.ethers.getContractFactory("ContentSubscription");
  const contract = await ContentSubscription.deploy(fee);
  await contract.deployed();

  console.log("ContentSubscription deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
