// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Auction {
    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public userBalances;
    
    constructor() {
        highestBid = 0;
        highestBidder = msg.sender;
    }
    
    function bid() public payable {
        require(msg.value > highestBid, "Highest bidder already exists.");
            userBalances[msg.sender] = msg.value;
            highestBid = msg.value;
            highestBidder = msg.sender;
    }
    
    function withdraw() public payable{
        uint amount = userBalances[msg.sender];
        if(amount > 0) {
	    require(amount != highestBid, "You can not withdraw the highest bid.");
            require(payable(msg.sender).send(amount), "Could not send amount to bidder.");
            userBalances[msg.sender] = 0;
        }
    }
    
    function getBidderBalance(address _addr) public view returns(uint) {
        return(userBalances[_addr]);
    }
    
    function HighestBidderAddress() public view returns(address) {
        return(highestBidder);
    }
    
    receive() external payable {}
}