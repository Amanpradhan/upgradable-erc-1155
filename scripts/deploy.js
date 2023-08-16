const hre = require("hardhat");

async function main() {
  const MyEIP1155 = await hre.ethers.getContractFactory("MyEIP1155");
  const myEIP1155 = await MyEIP1155.deploy();

  await myEIP1155.deployed();

  console.log("MyEIP1155 deployed to:", myEIP1155.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
