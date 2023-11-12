// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Here in 0.1v of Twitter Contract we are adding some more fucntionality using Arrays 
// We are adding or storing array of tweets of any user because user cannot Tweet One tweet he/she can tweet more than one tweet so to store those we required array of tweets 

contract Twitter {
    
    mapping(address => string[]) Tweet;

    function CreateTweet(string memory Content) public {
        Tweet[msg.sender].push(Content);
    }

    function ShowMyTweets() public view returns (string[] memory) {
        return Tweet[msg.sender];
    }

    function DeleteRecentTweet() public {
        Tweet[msg.sender].pop();
    }
    function GetTweetByInd(address user,uint256 index)public view returns (string memory)
    {
        return Tweet[user][index];
    }

    function DeleteMyTweets() public {
        delete Tweet[msg.sender];
    }

    
}
