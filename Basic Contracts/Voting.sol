// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
contract Voting{
    address public owner=msg.sender;
    mapping(address => bool) public voters;
    mapping(address => uint) public voteCount;
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    event registeredVoter(address Voter);
    event VoteCasted(address by, address to);
    function registerVoter(address _voter) public onlyOwner {
        voters[_voter] = true;
        emit registeredVoter(_voter);
    }
    function castVote(address Candidate) public {
        require(voters[msg.sender]==true,"Not registered for voting");
        voteCount[Candidate]+=1;
        emit VoteCasted(msg.sender, Candidate);
        voters[msg.sender]=false; //so that the voter cant vote again
    }
}