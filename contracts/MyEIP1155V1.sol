// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyEIP1155V1 is ERC1155Upgradeable, AccessControlUpgradeable {
    mapping(address => bool) private _whitelisted;
    bytes32 public constant URI_SETTER_ROLE = keccak256("URI_SETTER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    event Initialized(address indexed initializer, string uri, uint256 initialSupply);
    event URIChanged(string newUri, address indexed changedBy);
    event AddedToWhitelist(address indexed account, address indexed byWhom);
    event RemovedFromWhitelist(address indexed account, address indexed byWhom);


    function initialize(string memory uri) public initializer {
        __ERC1155_init(uri);
        __AccessControl_init();

        _grantRole(URI_SETTER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);

        emit RoleGranted(URI_SETTER_ROLE, msg.sender, msg.sender);
        emit RoleGranted(MINTER_ROLE, msg.sender, msg.sender);
        emit RoleGranted(ADMIN_ROLE, msg.sender, msg.sender);

        _mint(msg.sender, 1, 100*10**18, bytes("Project Token"));
        emit Initialized(msg.sender, uri, 100 * 10**18);
    }

    /**
     * @notice Changes the URI for the entire contract
     * @param newuri the new URI for the contract
     */
    function setURI(string memory newuri) public onlyRole(URI_SETTER_ROLE) {
        _setURI(newuri);
        emit URIChanged(newuri, msg.sender);
    }

    /**
     * @notice Fetches the URI for a given token ID
     * @param tokenId the token ID
     * @return the URI of the token
     */
    function getURI(uint256 tokenId) public view returns (string memory) {
        return this.uri(tokenId);
    }

    /**
     * @notice Mints tokens and assigns to given account
     * @param account recipient of tokens
     * @param id token id to mint
     * @param amount quantity of token id to mint
     */
    function mint(address account, uint256 id, uint256 amount) public onlyRole(MINTER_ROLE) {
        bytes memory data = "minting tokens";
        require(isWhitelisted(account), "Account is not whitelisted");
        _mint(account, id, amount, data);
    }

    /**
     * @notice Mints tokens in batch and assigns them to the given account
     * @param account The recipient of the minted tokens
     * @param ids Array of token IDs to mint
     * @param amounts Array of quantities of each token ID to mint
     */
    function mintBatch(address account, uint256[] memory ids, uint256[] memory amounts) public onlyRole(MINTER_ROLE) {
        bytes memory data = "minting tokens in batch";
        require(isWhitelisted(account), "Account is not whitelisted");
        _mintBatch(account, ids, amounts, data);
    }

    /**
     * @notice Grants the minter role to a specified account
     * @param account The account to be granted the minter role
     */
    function grantMinterRole(address account) public onlyRole(ADMIN_ROLE) {
        grantRole(MINTER_ROLE, account);
    }

    /**
     * @notice Revokes the minter role from a specified account
     * @param account The account from which the minter role will be revoked
     */
    function revokeMinterRole(address account) public onlyRole(ADMIN_ROLE) {
        revokeRole(MINTER_ROLE, account);
    }

    /**
     * @notice Adds an account to the whitelist
     * @param account The account to be added to the whitelist
     */
    function addToWhitelist(address account) public onlyRole(ADMIN_ROLE) {
        _whitelisted[account] = true;
        emit AddedToWhitelist(account, msg.sender);
    }

    /**
     * @notice Removes an account from the whitelist
     * @param account The account to be removed from the whitelist
     */
    function removeFromWhitelist(address account) public onlyRole(ADMIN_ROLE) {
        _whitelisted[account] = false;
        emit RemovedFromWhitelist(account, msg.sender);
    }

    /**
     * @notice Checks if an account is whitelisted
     * @param account The account to be checked
     * @return true if the account is whitelisted, false otherwise
     */
    function isWhitelisted(address account) public view returns (bool) {
        return _whitelisted[account];
    }

    /**
     * @notice Checks if the contract supports an interface
     * @param interfaceId The ID of the interface to check
     * @return true if the contract supports the interface, false otherwise
     */
    function supportsInterface(bytes4 interfaceId) public view override(ERC1155Upgradeable, AccessControlUpgradeable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
