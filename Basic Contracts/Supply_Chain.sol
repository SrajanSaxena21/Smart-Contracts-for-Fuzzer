// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
//Supply Chain
contract Item_Tracker{
    string public CurrentStage="Manufacturing";
    bool public Delivered;
    address public Manufacturer;
    address public Packager;
    address public Shop;
    function SetData_Manufacturer(address Account_Number ) public{
        Manufacturer=Account_Number;
    }
    function SetData_Packager(address Account_Number ) public{
        Packager=Account_Number;
    }
    function SetData_Shop(address Account_Number ) public{
        Shop=Account_Number;
    }
    modifier onlyManufacturer() {
        require(msg.sender == Manufacturer, "Only the Manufacturer can call this function");
        _;
    }
    modifier onlyPackaging() {
        require(msg.sender == Packager, "Only the Packager can call this function");
        _;
    }
    modifier onlyShop() {
        require(msg.sender == Shop, "Only the Packager can call this function");
        _;
    }
    function Sent_to_Packaging() public onlyManufacturer{
        Delivered=true;
    }
    function Received_by_Packaging() public onlyPackaging{
        require(Delivered==true,"Not Delivered yet");
        CurrentStage="Packaging";
        Delivered=false;
    }
    function Sent_to_Shop() public onlyPackaging{
        Delivered=true;
    }
    function Received_by_Shop() public onlyShop{
        require(Delivered==true,"Not Delivered yet");
        CurrentStage="Shop";

    }
}