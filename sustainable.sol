// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Sustainable, Green Blockchain Infrastructure
 * @dev Core smart contract for managing tokenized carbon credits
 */

contract SustainableGreenBlockchain {
    address public admin;
    uint256 public totalCredits;
    mapping(address => uint256) public creditBalances;

    // Events
    event CreditsIssued(address indexed to, uint256 amount);
    event CreditsRetired(address indexed from, uint256 amount);
    event CreditsTransferred(address indexed from, address indexed to, uint256 amount);

    constructor() {
        admin = msg.sender;
    }

    // Issue new carbon credits (admin only)
    function issueCredits(address to, uint256 amount) public {
        require(msg.sender == admin, "Only admin can issue credits");
        creditBalances[to] += amount;
        totalCredits += amount;
        emit CreditsIssued(to, amount);
    }

    // Retire (burn) credits to offset emissions
    function retireCredits(uint256 amount) public {
        require(creditBalances[msg.sender] >= amount, "Not enough credits to retire");
        creditBalances[msg.sender] -= amount;
        totalCredits -= amount;
        emit CreditsRetired(msg.sender, amount);
    }

    // Transfer credits to another user
    function transferCredits(address to, uint256 amount) public {
        require(creditBalances[msg.sender] >= amount, "Not enough credits to transfer");
        creditBalances[msg.sender] -= amount;
        creditBalances[to] += amount;
        emit CreditsTransferred(msg.sender, to, amount);
    }
}
