async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);

//   const balance = await deployer.getBalance(); // Use deployer's provider to get balance
//   console.log("Account balance:", ethers.utils.formatEther(balance));

  const Contract = await ethers.getContractFactory("TestElection");
  const contract = await Contract.deploy();

  console.log("Contract address:", contract.address);
  
  
    console.log("Contract address:", contract.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });