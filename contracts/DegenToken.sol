// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DengenToken is ERC20, Ownable {

    mapping(uint => uint) public storeItems;

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
        storeItems[1] = 100;
        storeItems[2] = 50;
        storeItems[3] = 60;
        storeItems[4] = 30;
    }

    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transferTokens(address to, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance.");
        _transfer(msg.sender, to, amount);
    }

    function burnTokens(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance.");
        _burn(msg.sender, amount);
    }

    function getStoreItems() public pure returns (string memory) {
        return "Store items: 1. Game merch (100 GTN) \n2. Game NFT (50 GTN) \n3. Game Outfit (60 GTN) \n4. Game Skin (30 GTN)";
    }

    function redeemItem(uint itemId) external {
        require(itemId > 0 && itemId <= 4, "Invalid item ID.");
        require(balanceOf(msg.sender) >= storeItems[itemId], "Insufficient balance.");
        _transfer(msg.sender, owner(), storeItems[itemId]);
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
