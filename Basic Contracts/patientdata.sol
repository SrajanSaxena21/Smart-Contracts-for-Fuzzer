// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract patientdata {
    address public owner;
    
    struct Patient {
        string name;
        uint256 age;
        string diagnosis;
        address createdBy;
    }

    mapping(address => Patient) public patients;

    event PatientAdded(address indexed patientAddress, string name, uint256 age, string diagnosis, address createdBy);

    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner");
        _;
    }

    modifier patientExists(address patientAddress) {
        require(bytes(patients[patientAddress].name).length != 0, "Patient does not exist");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addPatientData(address patientAddress, string memory name, uint256 age, string memory diagnosis) external onlyOwner {
        require(bytes(name).length > 0, "Name cannot be empty");
        require(bytes(diagnosis).length > 0, "Diagnosis cannot be empty");

        patients[patientAddress] = Patient({
            name: name,
            age: age,
            diagnosis: diagnosis,
            createdBy: msg.sender
        });

        emit PatientAdded(patientAddress, name, age, diagnosis, msg.sender);
    }

    function getPatientData(address patientAddress) external view patientExists(patientAddress) returns (string memory, uint256, string memory, address) {
        Patient memory patient = patients[patientAddress];
        return (patient.name, patient.age, patient.diagnosis, patient.createdBy);
    }
}
