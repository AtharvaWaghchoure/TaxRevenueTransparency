// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

contract FundMonitor {
    address public organization1;
    address public organization2;
    uint256 public allocatedFund;
    uint256 public transferredFund;

    event FundsAllocated(address indexed sender, uint256 amount);
    event FundsTransferred(address indexed sender, uint256 amount);

    constructor(address _organization1, address _organization2) {
        organization1 = _organization1;
        organization2 = _organization2;
    }

    function allocateFunds() external payable {
        require(msg.sender == organization1, "Only organization1 can allocate funds.");
        allocatedFund += msg.value;
        emit FundsAllocated(msg.sender, msg.value);
    }

    function transferFunds(uint256 amount) external {
        require(msg.sender == organization1, "Only organization1 can transfer funds.");
        require(allocatedFund >= amount, "Insufficient allocated funds.");
        allocatedFund -= amount;
        transferredFund += amount;
        emit FundsTransferred(msg.sender, amount);
        payable(organization2).transfer(amount);
    }
}