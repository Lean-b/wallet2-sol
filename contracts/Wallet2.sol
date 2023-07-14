// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Importación del contrato Ownable del paquete OpenZeppelin
import "@openzeppelin/contracts/access/Ownable.sol";

contract Wallet2 is Ownable {
    // Dirección destinataria para transferencias directas
    address private addressDirect;

    // Constructor del contrato que establece la dirección destinataria
    constructor(address _addressDirect) {
        addressDirect = _addressDirect;
    }

    // Evento emitido al recibir ether
    event Receives(address sender, uint256 value);

    // Evento emitido al realizar una transferencia
    event Transfer(uint256 amount, address indexed vendedor);

    // Mapping para almacenar los balances de los usuarios
    mapping(address => uint256) private _balance;

    // Función receive() para recibir ether
    receive() external payable {
        emit Receives(msg.sender, msg.value);
    }

    // Función withdraw() para retirar ether
    function withdraw(uint256 _amount) public onlyOwner {
        require(
            _amount > 0,
            "No se puede retirar una cantidad menor a 0 ether"
        );
        payable(owner()).transfer(_amount);
    }

    // Función directTransfer() para realizar una transferencia directa
    function directTransfer() public payable {
        require(
            msg.value > 1,
            "No se puede enviar una transferencia menor a 1 ether"
        );
        _directTransfer();
    }

    // Función interna para realizar la transferencia directa
    function _directTransfer() internal {
        require(msg.value > 0, "Debe enviar una cantidad positiva de ether.");
        payable(addressDirect).transfer(msg.value);
        emit Transfer(msg.value, addressDirect);
    }

    // Función transfer() para transferir ether a una dirección específica
    function transfer(address payable _to) public payable onlyOwner {
        require(
            msg.value > 0,
            "No se puede transferir una cantidad menor a 0 ether"
        );
        _to.transfer(msg.value);
    }

    // Función getBalance() para obtener el saldo del contrato
    function getBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }

    // Función getUserBalance() para obtener el saldo de un usuario
    function getUserBalance(address _owner) external view onlyOwner returns (uint256) {
        return address(_owner).balance;
    }

    // Función privada para establecer la dirección destinataria
    function setAddressDirect(address _addressDirect) private onlyOwner {
        addressDirect = _addressDirect;
    }

    // Función para obtener la dirección destinataria
    function getAddressDirect() public view returns (address) {  
        return addressDirect;}
      
}