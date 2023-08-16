// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Proxy
 * @dev This contract implements a proxy pattern for upgradable smart contracts.
 * It holds a reference to the implementation contract and delegates all calls to that contract.
 * The admin can upgrade the implementation contract, thus updating the logic of the proxy.
 */
contract Proxy {
    address internal _implementation;
    address internal _admin;

    constructor(address initialImplementation, address initialAdmin) {
        _implementation = initialImplementation;
        _admin = initialAdmin;
    }

    /**
     * @dev Returns the current implementation contract address.
     * @return The address of the current implementation contract.
     */
    function getImplementation() public view returns (address) {
        return _implementation;
    }

    /**
     * @dev Returns the current admin address.
     * @return The address of the current admin.
     */
    function getAdmin() public view returns (address) {
        return _admin;
    }

    /**
     * @dev Allows the admin to upgrade the implementation contract.
     * @param newImplementation The address of the new implementation contract.
     * @notice Only the admin can call this function.
     */
    function upgradeTo(address newImplementation) public {
        require(msg.sender == _admin, "Only admin can upgrade");
        _implementation = newImplementation;
    }

    fallback() external payable {
        address implementation = getImplementation();
        require(implementation != address(0), "Implementation not set");

        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), implementation, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)
            
            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }

    receive() external payable {

    }
}
