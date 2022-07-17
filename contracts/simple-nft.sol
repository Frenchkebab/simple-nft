// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

contract SimpleNFT {
    
    /**
     * You can know token id in advance,
     * but you can't know which address will own it in advance.
     * (also you can't iterate with address, additional list with address will cost gas)
     */
    mapping(uint256 => address) private _owners;

    function mint(uint256 _tokenId) external {
        require(_owners[_tokenId] == address(0), "already minted");
        require(_tokenId < 100, "_tokenId too large");
        _owners[_tokenId] = msg.sender;
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        require(_owners[_tokenId] != address(0), "no such token!");
        return _owners[_tokenId];
    } 

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        // check if the token id exists
        require(_owners[_tokenId] != address(0), "token does not exist");
        require(_owners[_tokenId] == _from, "the address does not own the token");
        require(msg.sender == _from, "required to be owner");
        _owners[_tokenId] = _to;
    }
}