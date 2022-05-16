pragma solidity ^0.8.4;

//The contract allows only the creator to create new coins(different issuance schemes are possible)
// Anyone can send coins to each other without a need for registering with a username and password, all you need is an Ethereum keypair

contract Coin {
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    //Constructor only runs when
    constructor() {
        minter = msg.sender;
    }

    //Make new coins and send them to an address
    // only the owner can send these coins

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // send any amount of coins 
    // to an existing wallet

    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
        revert InsufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
    
}