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
        uint startInsurance;
        uint endInsurance;
    }
    // To create a customer
    function registeCustomer(string memory newName, uint newAge) public onlyOwner{
        require(
            users[msg.sender].userAddress != msg.sender,
            "You are already have "
        );
        require(
            newAge >= 18,
            "You are under the age"
        );
        require(
            users[msg.sender].startInsurance <= 0,
            "Your Insurance is expired"
        );
        users[msg.sender] = User(
            newName,
            msg.sender,
            newAge,
            0,
            0
        );
        registeredCustomer++;
    }
    // To Subscribe - Like - Share
    function registeInsurance() public payable {
        require(
            users[msg.sender].userAddress == msg.sender,
            "You are not a customer"
        );
        require(
            balanceOf(msg.sender) >= 0,
            "You don't have balance enough"
        );
        require(
            users[msg.sender].endInsurance < block.timestamp,
            "Your Insurance is still active"
        );
        transferFrom(msg.sender, insuranceAddress, 0);
        // starts now
        users[msg.sender].startInsurance = block.timestamp;
        // ends after 1 year from now
        users[msg.sender].endInsurance = block.timestamp + 31556926;
        registeredInsurance++;
    }
}
