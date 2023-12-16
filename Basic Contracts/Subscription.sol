// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
contract SubscriptionContentDelivery {
    address public owner;
    uint public subscriptionFee;
    mapping(address => uint256) public subscribers;
    mapping(address => bool) public service;

    event SubscriptionPurchased(address subscriber, uint timestamp);
    event ContentDelivered(address subscriber, string content, uint timestamp);
    event Data_was_Stored(address Account_Number, uint256 Balance);
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    function SetData(address Account_Number, uint256 Balance) public onlyOwner{
        subscribers[Account_Number]=Balance;
        emit Data_was_Stored( Account_Number, Balance);
    }
    constructor(uint _subscriptionFee) {
        owner = msg.sender;
        subscriptionFee = _subscriptionFee;
    }

    function purchaseSubscription() external payable {
        require(subscribers[msg.sender]>=subscriptionFee,"Insufficient Funds");
        subscribers[msg.sender]-=subscriptionFee;
        service[msg.sender]=true;
        emit SubscriptionPurchased(msg.sender, block.timestamp);
    }

    function checkStatus(address Account) external view returns(bool){
        return service[Account];
    }

}