// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Proxy {
    address internal _implementation;
    address internal _admin;

    constructor(address initialImplementation, address initialAdmin) {
        _implementation = initialImplementation;
        _admin = initialAdmin;
    }

    function getImplementation() public view returns (address) {
        return _implementation;
    }

    function getAdmin() public view returns (address) {
        return _admin;
    }

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
