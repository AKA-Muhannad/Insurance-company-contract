// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InsuranceContract is ERC20, Ownable {
    address public insuranceAddress = 0xd7b5B1e52369F1402Ba350d7f5Dd3D247717c157; // Osama's insurance company address
    uint public registeredInsurance;
    uint public registeredCustomer;

    constructor() ERC20("Muhannad Insurance", "MIT") {}

    mapping(address => User) public users;

    struct User {
        string userName;
        address userAddress;
        uint userAge;
        uint userBalance;
        uint startInsurance;
        uint endInsurance;
    }
    
    function registeCustomer(string memory newName, uint newAge) public payable{
        require(
            newAge >= 18,
            "You are under the age"
        );
        require(
            balanceOf(msg.sender) <= 0,
            "You don't have balance enough"
        );
        require(
            users[msg.sender].startInsurance <= 0,
            "Your Insurance is expired"
        );
        uint newBalance = balanceOf(msg.sender);
        transferFrom(msg.sender, insuranceAddress, 0);
        users[msg.sender] = User(
            newName,
            msg.sender,
            newAge,
            newBalance,
            block.timestamp,
            block.timestamp + 31556926
        );
        registeredCustomer++;
        registeredInsurance++;
    }
}
