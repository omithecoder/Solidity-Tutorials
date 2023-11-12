// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Events : Solidity event are nothing but a Notification system for a blockchain means this event tells us that i do this this task compleletly means events are fired when a important task is completed to notify all other users on the blockchain that this specific task is completed

// events also carry some additional information with it like notification in our smartphone 
// like suppose message notification cosist some content of message and author/sender with the timestamp of message 
// similarly we can send this type of data with using events


// here in parameter which we want to pass by event there is indexed typed parameter
// this parameter are efficient for searching and sorting/filtering the event 
//Inshort we can search/filter out events by using this indexed parameter very easily
// But because of it's complexity more than 3 indexed parameter in one event is not allowed

contract Eventexample{

    // We are creating event which notify all when any New User Register

    struct User
    {
        address UserAdd;
        string name;
        uint8 age;
    }

    mapping (address => User) User_info;
    event UserRegister (string name,address UserAdd,uint8 age);

    function Register(string memory name,uint8 age)public
    {
        User memory NewUser = User({
            UserAdd : msg.sender,
            name:name,
            age:age
        });

        User_info[msg.sender]= NewUser;
        emit UserRegister(name, msg.sender, age);
    }
}

