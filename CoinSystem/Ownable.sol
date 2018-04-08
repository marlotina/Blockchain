pragma solidity ^0.4.17;

contract Ownable {
    address public owner;
    
    function Ownable() public { 
        owner = msg.sender;    
    }
    
    function transferOwner(address newOwner) public isOwner { 
        require(newOwner != address(0));
        owner = newOwner;
    }
    
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
}