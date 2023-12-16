// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract crowdfund {
    address public creator; 
    uint public goal; 
    uint public deadline; //timestamp
    mapping(address => uint) public contributions; 
    uint public total_contributions; 

    enum State { Fundraising, Successful, Expired }
    State public state = State.Fundraising;

    event funded(address contributor, uint amount);
    event goalreached(uint total_amount);
    event campaignexpired(uint total_amount);

    modifier onlyCreator() {
        require(msg.sender == creator, "Not the creator");
        _;
    }

    modifier inState(State _state) {
        require(state == _state, "Invalid state for this operation");
        _;
    }

    modifier deadlineReached() {
        require(block.timestamp >= deadline, "Deadline has not been reached");
        _;
    }

    constructor(address _creator, uint _goal, uint _duration) {
        creator = _creator;
        goal = _goal;
        deadline = block.timestamp + _duration * 1 days;
    }

    //for users to contribute to the crowdfund
    function contribute() external payable inState(State.Fundraising) {
        require(msg.value > 0, "Contribution must be greater than zero");
        contributions[msg.sender] += msg.value;
        total_contributions += msg.value;
        emit funded(msg.sender, msg.value);
        if (total_contributions >= goal) {
            state = State.Successful;
            emit goalreached(total_contributions);
        }
    }

    //for creator to wirthdraw funds after fund is successful
    function withdrawFunds() external onlyCreator inState(State.Successful) {
        payable(creator).transfer(total_contributions);
    }

    //for users to reclaim their funds in case the fund is expired
    function reclaimFunds() external inState(State.Expired) {
        uint amount = contributions[msg.sender];
        require(amount > 0, "No contribution to reclaim");
        contributions[msg.sender] = 0;
        total_contributions -= amount;
        payable(msg.sender).transfer(amount);
    }

    function checkState() external {
        if (block.timestamp >= deadline && total_contributions < goal && state == State.Fundraising) {
            state = State.Expired;
            emit campaignexpired(total_contributions);
        }
    }
}
