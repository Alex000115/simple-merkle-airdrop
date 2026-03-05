# Simple Merkle Airdrop

A high-performance solution for distributing tokens to a large number of users. Instead of storing a massive mapping of addresses on-chain (which is prohibitively expensive), this repository uses a Merkle Root to verify eligibility, offloading data storage to the frontend/IPFS.

## Features
* **Extreme Gas Efficiency:** Only stores a single 32-byte hash (the Merkle Root) to represent the entire list of eligible claimants.
* **Secure Verification:** Uses OpenZeppelin's `MerkleProof` library to prevent unauthorized claims.
* **One-Time Claim:** Built-in tracking to ensure each eligible address can only claim their allocation once.

## Getting Started
1. Generate a Merkle Tree from your whitelist of addresses and amounts using a JavaScript library (like `merkletreejs`).
2. Deploy `MerkleAirdrop.sol` with the Merkle Root and the Token address.
3. Users provide their specific "proof" (generated off-chain) to the `claim` function to receive their tokens.

## License
MIT
