// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title MerkleAirdrop
 * @dev Professional implementation for gas-efficient token distributions.
 */
contract MerkleAirdrop is ReentrancyGuard {
    address public immutable token;
    bytes32 public immutable merkleRoot;

    mapping(address => bool) public hasClaimed;

    event Claimed(address indexed account, uint256 amount);

    constructor(address _token, bytes32 _merkleRoot) {
        token = _token;
        merkleRoot = _merkleRoot;
    }

    /**
     * @dev Allows eligible users to claim tokens by providing a Merkle proof.
     * @param amount The amount of tokens the user is entitled to.
     * @param merkleProof The sibling hashes required to reconstruct the Merkle Root.
     */
    function claim(uint256 amount, bytes32[] calldata merkleProof) external nonReentrant {
        require(!hasClaimed[msg.sender], "Airdrop already claimed.");

        // Verify the leaf hash (msg.sender + amount)
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(msg.sender, amount))));
        
        require(MerkleProof.verify(merkleProof, merkleRoot, leaf), "Invalid Merkle proof.");

        hasClaimed[msg.sender] = true;
        require(IERC20(token).transfer(msg.sender, amount), "Transfer failed.");

        emit Claimed(msg.sender, amount);
    }
}
