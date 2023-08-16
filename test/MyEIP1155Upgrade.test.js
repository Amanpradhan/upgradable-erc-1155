const { ethers, upgrades } = require("hardhat");
const { expect } = require("chai");

describe("MyEIP1155 upgrade", function () {
    it("Should upgrade the contract and preserve state", async function () {
        const MyEIP1155V1 = await ethers.getContractFactory("MyEIP1155V1");
        const MyEIP1155V2 = await ethers.getContractFactory("MyEIP1155V2");

        const myEIP1155V1 = await upgrades.deployProxy(MyEIP1155V1, ["Initial URI for V1"]);
        // await myEIP1155V1.deployed();

        let to = "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"; 
        let tokenId = 1;     
        let amount = 1000;   

        console.log("running addToWhitelist");
        await myEIP1155V1.addToWhitelist(to);
        
        console.log("running mint");
        await myEIP1155V1.mint(to, tokenId, amount);
        
        console.log(myEIP1155V1.getAddress)

        console.log("running upgradeProxy");

        
        const myEIP1155V2 = await upgrades.upgradeProxy(myEIP1155V1, MyEIP1155V2);
        let balance = await myEIP1155V1.balanceOf(to);
        console.log("balance")

        
        // expect(await myEIP1155V2.balanceOf()).to.equal();
    });
  });
  
