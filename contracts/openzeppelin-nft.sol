// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OpenZeppelinNFT is ERC721, Ownable {

    uint256 public tokenSupply = 0;
    uint256 public constant MAX_SUPPLY = 5;
    uint256 public constant PRICE = 1 ether;



    constructor() ERC721("MyNFT", "MN") {
        
    }

    function mint() external {
        // 0, 1, 2, 3, 4
        require(tokenSupply < MAX_SUPPLY, "supply used up");
        _mint(msg.sender, tokenSupply);
        tokenSupply++;
    }

    function viewBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    // to get rid of the risk that the contract becomes out of control,
    // we just override the function
    function renounceOwnership() public override {
        require(false, "cannot renounce");
    }

    function transferOwnership(address newOwner) public override {
        require(false, "cannot transfer renounce");
    } 
}