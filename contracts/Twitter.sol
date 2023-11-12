// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Here we are starting with Twitter Smart Contract
// In this First Version We are creating a initial map betweent user and Tweet
// And add/create a function to add a Tweet through the user account
// Also Adding Delete Tweet and ShowMyTweet Function

contract Twitter {
    // Add Map
    // Map User(address) => tweet(String)
    // here Mapping is similar like Hashmaps in other programming language
    // Syntax for mapping = mapping(key(datatype) => value(datatype)) map_Name;
    mapping(address => string) Tweet;

    function CreateTweet(string memory Content) public {
        Tweet[msg.sender] = Content;
    }

    function ShowMyTweets() public view returns (string memory) {
        return Tweet[msg.sender];
    }

    function DeleteMyTweets() public {
        // delete function is use to delete the respective map (key-value) pair 
        delete Tweet[msg.sender];
    }

    // msg.sender is a global variable that represents the address of the account (or contract) that is currently calling or interacting with the smart contract. It is part of the msg global variable, which also includes other information about the current transaction.

    // msg.sender is commonly used to identify the sender of a transaction, allowing smart contracts to keep track of the account or contract initiating the interaction.
    // It is often used for access control, authentication, and to record the origin of state changes within the contrac
}
