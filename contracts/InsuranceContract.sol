// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InsuranceContract is ERC20, Ownable {
    address userAddress;
    constructor() ERC20("Muhannad Insurance", "MIT") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    mapping (address => User) public users;

    struct User{
        string userName;
        address userAddress;
        uint userAge;
        uint userBalance;
    }
    modifier userCheck{
        require(userAddress == msg.sender, "You are not the user");_;
    }

}
