# upgradable-erc-1155

## Introduction
### MyEIP1155V1 is a smart contract that extends the ERC1155 token standard and integrates access control functionalities. It allows the owner to mint new tokens, set URIs for token types, manage a whitelist of approved addresses, and assign special roles to addresses for administrative tasks.

## Functions
### initialize(string memory uri)
Initializes the contract with a base URI for tokens.

### setURI(string memory newuri)
Sets a new URI for the tokens. Only an address with the URI_SETTER_ROLE can call this function.

### getURI(uint256 tokenId)
Gets the URI associated with a given token ID.

### mint(address account, uint256 id, uint256 amount)
Mints a new token of a particular ID and sends it to a specified account. Only an address with the MINTER_ROLE can call this function, and the recipient account must be whitelisted.

### mintBatch(address account, uint256[] memory ids, uint256[] memory amounts)
Mints new tokens of multiple IDs and sends them to a specified account. Similar to the mint function but allows for batch processing.

### grantMinterRole(address account)
Grants the MINTER_ROLE to a specified address. Only an address with the ADMIN_ROLE can call this function.

### revokeMinterRole(address account)
Revokes the MINTER_ROLE from a specified address. Only an address with the ADMIN_ROLE can call this function.

### addToWhitelist(address account)
Adds a specified address to the whitelist. Only an address with the ADMIN_ROLE can call this function.

### removeFromWhitelist(address account)
Removes a specified address from the whitelist. Only an address with the ADMIN_ROLE can call this function.

### isWhitelisted(address account)
Checks whether a specified address is whitelisted. Returns a boolean value.

### supportsInterface(bytes4 interfaceId)
Checks whether the contract supports an interface with a specified ID.

### setNewMetadata(uint256 tokenId, string memory metadata)
Sets new metadata for a specific token ID. This can be used to associate additional information with a token.



## Events
### Initialized(address indexed initializer, string uri, uint256 initialSupply)
### URIChanged(string newUri, address indexed changedBy)
### AddedToWhitelist(address indexed account, address indexed byWhom)
### RemovedFromWhitelist(address indexed account, address indexed byWhom)

# MyEIP1155V2 Smart Contract
## The MyEIP1155V2 contract extends the MyEIP1155V1 contract and introduces additional functionality for managing token metadata. This allows for the association of string metadata with specific token IDs, and is designed for testing and further extension of the contract features.

### setNewMetadata(uint256 tokenId, string memory metadata)
Sets new metadata for a specific token ID.

# Proxy Smart Contract
The Proxy contract allows for the transparent upgrading of contract logic while preserving contract state and the address of the contract. It delegates calls to an implementation contract, which can be upgraded by an admin account.

### constructor(address initialImplementation, address initialAdmin)
Initializes the Proxy contract with the initial implementation and admin address.

### @param initialImplementation: The initial contract logic implementation address.
### @param initialAdmin: The initial admin address.
### getImplementation()
Returns the current implementation address.

### getAdmin()
Returns the current admin address.

### upgradeTo(address newImplementation)
Upgrades the contract to a new implementation.

