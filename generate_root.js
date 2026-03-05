const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');
const { ethers } = require('ethers');

// Sample whitelist: [address, amount]
const whitelist = [
    ["0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", ethers.parseEther("100")],
    ["0x70997970C51812dc3A010C7d01b50e0d17dc79C8", ethers.parseEther("200")]
];

const leaves = whitelist.map(x => 
    keccak256(ethers.solidityPacked(["address", "uint256"], [x[0], x[1]]))
);

const tree = new MerkleTree(leaves, keccak256, { sortPairs: true });
const root = tree.getHexRoot();

console.log("Merkle Root:", root);
// Use this root when deploying the contract.
