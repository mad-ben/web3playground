// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";

contract MyAlchToken is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAXSUPPLY = 10000; //Constants are in all capital letters. Good practice
    //***Weekly challenge***
    uint256 MAXMINT = 5; //Tokens per user
    mapping (address => uint) public tokensMinted; //count
    //***Weekly challenge end***
    constructor() ERC721("MyAlchToken", "MaTK") {}

    function safeMint(address to, string memory uri) public {
        uint256 tokenId = _tokenIdCounter.current(); //stores current ID 
        require(tokenId <= MAXSUPPLY,"All NFTs have been minted"); //Check if all NFTs have been minted.
        //***Weekly challenge***
        require(tokensMinted[to] <= MAXMINT, "Cannot mint more NFTs"); //Check if account can mint more tokens. Cannot mint more than 5.
        tokensMinted[to] += 1;
        //***Weekly challenge end***
        _tokenIdCounter.increment(); //increment token ID after new mint
        _safeMint(to, tokenId); //mint NFT
        _setTokenURI(tokenId, uri); // assign token ID to URI
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) //What kind of features are supported
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
