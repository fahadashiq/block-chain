// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Trust {
    
    struct Kid {
        uint amount;
        uint maturity;
        bool paid;
    }
    
    mapping(address => Kid) public kids;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function addKid(address kid, uint timeToMaturity) external payable {
        require(msg.sender == admin, 'Only admin can create kids');
        require(kids[kid].amount == 0, 'Kid already exists');
        kids[kid] = Kid(msg.value, block.timestamp +  timeToMaturity, false);
    }

     function withdraw() external {
        Kid storage kid = kids[msg.sender];
        require(block.timestamp >= kid.maturity, 'Grow up');
        require(kid.amount > 0, 'Only kid can withdraw');
        require(kid.paid == false, 'Already paid');
        payable(msg.sender).transfer(kid.amount); 
    }

/*
    address public kid;
    uint public maturity;
    constructor(address _kid, uint timeToMaturity) payable {
        kid = _kid;
        maturity = block.timestamp +  timeToMaturity;
    }

    function withdraw() external {
        require(block.timestamp >= maturity, 'Grow up');
        require(msg.sender == kid, 'Only kid can withdraw');
        payable(msg.sender).transfer(address(this).balance); 
    }
    */
}