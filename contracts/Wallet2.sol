// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract Wallet2 is Ownable {
    address private addressDirect;


    constructor(address _addressDirect) {
        addressDirect = _addressDirect;
     
    }

    event Receives(address sender, uint256 value);
    event Transfer(uint256 amount, address indexed vendedor);

    mapping(address => uint256) private _balance;

    receive() external payable {
        emit Receives(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public onlyOwner {
        require(
            _amount > 0,
            "No se puede retirar una cantidad menor a 0 ether"
        );
        payable(owner()).transfer(_amount);
    }

    function directTransfer() public payable {
        require(
            msg.value > 1,
            "No se puede enviar una tranferencia menor a 1 ether"
        );
        _directTransfer();
    }

    function _directTransfer() internal {
        require(msg.value > 0, "Debe enviar una cantidad positiva de ether.");
        payable(addressDirect).transfer(msg.value);
        emit Transfer(msg.value, addressDirect);
    }

    function transfer(address payable _to) public payable onlyOwner {
        require(
            msg.value > 0,
            "No se puede transferir una cantidad menor a 0 ether"
        );
        _to.transfer(msg.value);
    }

    function getBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }

    function getUserBalance(address _owner) external view onlyOwner returns (uint256) {
        return address(_owner).balance;
    }

    function setAddressDirect(address _addressDirect) private onlyOwner {
        addressDirect = _addressDirect;
    }

    function getAddressDirect() public view returns (address) {
        return addressDirect;
    }
}
