// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract bank {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function deposit() external payable {
        balance += msg.value;
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(amount <= balance, "Insufficient balance");
        payable(owner).transfer(amount);
        balance -= amount;
    }

    // haven't used onlyowner modifier so anyone can call this function
    function transferOwnership(address newOwner) external {
        owner = newOwner;
    }
}
