// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Structure : Structures in Solidity are as same in other programming language they are nothing but a storage which can store multiple data elements of different types we also called structure as Array of different datatypes

contract structure {
    struct student {
        string Name;
        address Account;
        uint8 age;
        string Location;
    }

    mapping(address => student) Student_data;

    function AddStudent(
        string memory name,
        uint8 Age,
        string memory loc
    ) public {
        student memory NewStud = student({
            Name: name,
            Account: msg.sender,
            age: Age ,
            Location: loc
        });

        Student_data[msg.sender] = NewStud;
    }

    function DeleteMyData() public {
        delete Student_data[msg.sender];
    }

    function ShowMyData() public view returns (student memory) {
        return Student_data[msg.sender];
    }
}
