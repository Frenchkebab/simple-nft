// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";

contract SimpleNFT {
    // associate this library to uint256
    using Strings for uint256;

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    
    /**
     * You can know token id in advance,
     * but you can't know which address will own it in advance.
     * (also you can't iterate with address, additional list with address will cost gas)
     */
    mapping(uint256 => address) private _owners;
    mapping(address => mapping(address => bool)) private _operators;
    mapping(address => uint256) private _balances;

    string baseURL = "https://example.com/images/";

    function mint(uint256 _tokenId) external {
        require(_owners[_tokenId] == address(0), "already minted");
        require(_tokenId < 100, "_tokenId too large");
        emit Transfer(address(0), msg.sender, _tokenId);
        _owners[_tokenId] = msg.sender;

        _balances[msg.sender] += 1;
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        require(_owners[_tokenId] != address(0), "no such token!");
        return _owners[_tokenId];
    } 

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        // check if the token id exists
        require(_owners[_tokenId] != address(0), "token does not exist");
        require(_owners[_tokenId] == _from, "the address does not own the token");

        // msg.sender can obviously move his own assets
        // or if msg.sender is approved operator, then we allow this.
        require(msg.sender == _from || _operators[_from][msg.sender], "required to be owner");

        emit Transfer(_from, _to, _tokenId);
        // after this nft has been transfered, we should set this to be false back again
        _operators[_from][msg.sender] = false;
        _owners[_tokenId] = _to;

        _balances[_from] -= 1;
        _balances[_to] += 1;
    }

    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        
        require(_owners[_tokenId] != address(0), "does not exist");

        return string(abi.encodePacked(baseURL, _tokenId.toString(), ".jpeg"));
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        _operators[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function isApprovedForAll(address _owner, address _operator) external view returns (bool) {
        return _operators[_owner][_operator];
    }

    function balanceOf(address _owner) external view returns (uint256) {
        require(_owner != address(0), "zero address");
        return _balances[_owner];
    }
}