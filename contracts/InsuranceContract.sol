// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InsuranceContract is ERC20, Ownable {
    address public insuranceAddress = 0xd7b5B1e52369F1402Ba350d7f5Dd3D247717c157; // Osama's insurance company address
    uint public registeredInsurance; // number of insurance
    uint public registeredCustomer; // number of customers

    constructor() ERC20("Muhannad Insurance", "MIT") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    mapping(address => User) public users;

    struct User {
        string userName;
        address userAddress;
        uint userAge;
        uint userBalance;
        uint startInsurance;
        uint endInsurance;
    }
    modifier checkUser() {
        require(
            users[msg.sender].userAddress == msg.sender,
            "You don't have membership"
        );
        _;
    }
    modifier checkBalance() {
        require(
            //                              1 as default amount
            users[msg.sender].userBalance >= 1,
            "You don't have balance enough"
        );
        _;
    }

    function registeCustomer(string memory newName, uint newAge) public {
        uint newBalance = balanceOf(msg.sender);
        users[msg.sender] = User(
            newName,
            msg.sender,
            newAge,
            newBalance,
            0,
            0
        );
        registeredCustomer++;
    }
    function registeInsurance() public {
        //           from me to osama with 1 Wei   
        transferFrom(msg.sender, insuranceAddress, 1);
        users[msg.sender].startInsurance = block.timestamp; // time of start the registration which's now
        users[msg.sender].endInsurance = block.timestamp + 31556926; // time of end the registration which's after 1 year
        registeredInsurance++;
    }
}
