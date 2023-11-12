// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 1️⃣ Imherit from the Multiplayer Game
// 2️⃣ Call the parent joinGame() function
// HINT: you might have to use the super keyword
// 3️⃣ Increment playerCount in joinGame() function

// MultiplayerGame contract
contract MultiplayerGame {
    mapping(address => bool) public players;

    function joinGame() public virtual {
        players[msg.sender] = true;
    }
}

// Game contract inheriting from MultiplayerGame
contract Game is MultiplayerGame {
    string public gameName;
    uint256 public playerCount;

    constructor(string memory _gameName) {
        gameName = _gameName;
        playerCount = 0;
    }

    function startGame() public {
        // Perform game-specific logic here
    }

    function joinGame() public override {
        super.joinGame();
        // "super" keyword is use to call functions in superContract means Parent contract of the Game contract or contract whose this contract is child
        // here super.joinGame() directly calls the joinGame function in parent class directly
        playerCount++;
    }

    
}