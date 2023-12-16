// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract Fund_Transfer{
    mapping (address => uint256) Account;
    event Data_was_Stored(address Account_Number, uint256 Balance);
    event Fund_Transfer_Successful(address from, address to, uint256 amount_given);
    function SetData(address Account_Number, uint256 Balance) public{
        Account[Account_Number]=Balance;
        emit Data_was_Stored( Account_Number, Balance);
    }
    function Transfer(address Account_Number1, uint256 Amount, address Account_Number2) public {
        //From Acount_Number 1 to Account_Number2
        Account[Account_Number1]-=Amount;
        Account[Account_Number2]+=Amount;
        emit Fund_Transfer_Successful(Account_Number1,Account_Number2,Amount);
    }
    function CheckBalance(address Account_Number) public view returns(uint256){
        return Account[Account_Number];
    }

}