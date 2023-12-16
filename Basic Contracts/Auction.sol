// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Auction {
    address public owner=msg.sender;
    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;
    mapping (address => uint256) Account;
    event BidPlaced(address bidder, uint amount);
    event Winner(address bidder);
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    function SetData(address Account_Number, uint256 Balance) public{
        Account[Account_Number]=Balance;
    }
    function placeBid(address Account_Number,uint256 Bid) public {
        require(Bid > highestBid, "Bid must be higher than the current highest bid");
        require(Bid< Account[Account_Number],"You don't have sufficient balance");
        highestBidder = Account_Number;
        highestBid = Bid;
        emit BidPlaced(Account_Number, Bid);
    }
    function endAuction() public onlyOwner  {
        require(highestBidder != address(0), "Auction has no winner");
        Account[highestBidder]-=highestBid;
        Account[owner]+=highestBid;
        emit Winner(highestBidder);
    }
    function CheckBalance(address Account_Number) public view returns(uint256){
        return Account[Account_Number];
    }
}
