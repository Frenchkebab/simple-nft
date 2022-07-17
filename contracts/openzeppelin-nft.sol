// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract OpenZeppelinNFT is ERC721 {

    uint256 public tokenSupply = 0;

    constructor() ERC721("MyNFT", "MN") {

    }

    function mint() external {
        _mint(msg.sender, tokenSupply);
        tokenSupply++;
    }
}