// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// 1️⃣ Create a new Player and save it to players mapping with the given data


contract User {
    struct Player {
        address playerAddress;
        string username;
        uint256 score;
    }

    mapping(address => Player) public players;

    function createUser(address userAddress, string memory username) external  {
        require(players[userAddress].playerAddress == address(0), "User already exists");
        // players[userAddress].playerAddress ==  address(0) specifies that the user with address => userAddress is SignedIn or Not if signedin then in players[userAddress].playerAddress != null or address(0)

        // Create a new player here 👇
        Player memory newPlayer = Player({
            playerAddress : userAddress,
            username: username,
            score : 0
        });

        players[userAddress]=newPlayer;

    }
}