pragma solidity ^0.4.17;

contract Lottery {
    // type, visibility, variable name
    address public manager;
    address[] public players;
    
    constructor() public {
        // msg is a global variable
        manager = msg.sender;
    }
    
    function enter() public payable {
        // msg.value gives wei sent in transaction
        // .01 ether converts to wei
        
        require(msg.value > .01 ether);
        
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        // keccak256, block, now (current time) are global
        return uint(keccak256(block.difficulty, now, players));
    }
    
    function pickWinner() public {
        // verifies manager is picking the winner            
        require(msg.sender == manager);
        
        uint index = random() % players.length;
        
        // sending all contract funds to winner
        players[index].transfer(this.balance);
        
        // (0) initializes array with no elements
        players = new address[](0);
    }
    
    // view means it doesn't change data in the contract
    function getPlayers() public view returns (address[]) {
        return players;
    }
}