## Simple NFT tutorial

https://www.youtube.com/watch?v=dmyADPRG9r4

This loosly follows ERC-721 specification for better learning.

### transferFrom vs safeTransferFrom

`safeTransferFrom` first checks if the recipient is a smart contract.
If you transfer an NFT to a smart contract, and the smart contract does not have any ability
to transfer the NFT again, then it will get stuck their.

`transferFrom` doesn't check if the recipient is a smart contract.

### What if we just point to the jpeg of the image?

It's the combination of the smart contract address and tokenId that makes NFT unique

### How to use `.toString()` in solidity

https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol


### Token Approval

You can query who a specific address approved

https://etherscan.io/tokenapprovalchecker

### How can opensea know the tokenId?

```solidity
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
```

https://etherscan.io/address/0x1a92f7381b9f03921564a437210bb9396471050c#events

if we convert this to decimal we can figure out which tokenId it is.


### `constant` variable

`constant` variables are more gas efficient than regular variables.
(Check out the gas course!)


