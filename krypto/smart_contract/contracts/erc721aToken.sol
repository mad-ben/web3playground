// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "erc721a/contracts/ERC721A.sol";  

contract MyAlchToken_Opt is ERC721A {

    string public tokenBaseURI ="ipfs://QmThQtHjcxxTd83yFiXduk4HD3Us2j7C3hDbG746zW2S4j";

    constructor () ERC721A ("MyAlchToken", "MaTKo") {}

    function mint (uint256 quantity) external payable {
        _safeMint(msg.sender, quantity);
    }

    /**
        * See original function in ERC721A.sol
        * Removed first line to use onlt baseURI and not append the tokenID
        * If NFTs are imported inside a folder, than do not override this function.
    */
     function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
      
        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, tokenId)) : '';
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return tokenBaseURI;
    }
 
}