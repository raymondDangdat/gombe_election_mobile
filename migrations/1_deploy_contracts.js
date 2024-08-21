const TestElection = artifacts.require("TestElection");
module.exports = function (deployer) {
    console.log("Deploy method called::::::::::::::::::");
    deployer.deploy(TestElection);
}


// const Election = artifacts.require("Election");

// module.exports = function(deployer) {
//   deployer.deploy(Election)
//     .then(() => console.log("Election deployed"))
//     .catch(error => console.error("Deployment failed:", error));
// };