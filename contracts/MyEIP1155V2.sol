// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyEIP1155V1.sol";

contract MyEIP1155V2 is MyEIP1155V1 {
    
    // adding new field to be introduced along with previous contract for testing
    mapping(uint256 => string) public newMetadata;

    /**
     * @notice Sets new metadata for a specific token ID
     * @param tokenId The ID of the token for which the metadata will be set
     * @param metadata The new metadata string to associate with the token ID
     */
    function setNewMetadata(uint256 tokenId, string memory metadata) public {
        // require(_isApprovedOrOwner(_msgSender(), tokenId), "Caller is not owner nor approved");
        // just a test
        newMetadata[tokenId] = metadata;
    }
}
