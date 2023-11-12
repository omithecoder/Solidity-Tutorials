// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Here in Twitter 0.3v we are adding a limit on tweet Length using "require" Conditionals

contract Twitter
{
    // defining Structure
    struct Tweet
    {
        string content;
        address author;
        uint256 timestamp;
        address[] likes;
        uint256 LikesCount;
    }

    uint256 constant TweetLength = 10;


    address[] li;
    mapping (address => Tweet[]) Tweet_info;
    function createTweet(string memory _tweet) public {
        // Here we use Memory Because We tell Solidity that When this structure is created we save this in temp memory as function exection done then we remove this memory

        // Here We are adding String Length limit 
        // Note : Here we cannot find string length directly using string_name.length instead of that we suppose tto first convert the string into bytes and then we find the length of that bytes string using bytes(string_name).length 
        
        require(bytes(_tweet).length <= TweetLength ,"Tweet Length is Exceed!");

        Tweet memory NewTweet = Tweet({
            content:_tweet,
            author:msg.sender,
            timestamp:block.timestamp,
            likes:li,
            LikesCount:0
        });

        Tweet_info[msg.sender].push(NewTweet);
    }

    function GetAllTweets() public view returns(Tweet[] memory)
    {
        return Tweet_info[msg.sender];
    }

    function GetTweet(address User,uint Index)public view returns (Tweet memory)
    {
        return Tweet_info[User][Index-1];
    }

    function DeleteRecentTweet()public
    {
        Tweet_info[msg.sender].pop();
    }

    function DeleteAllTweets()public {
        delete Tweet_info[msg.sender];
    }

    function GiveLikes(address User,uint256 TweetIndex)public 
    {
        Tweet_info[User][TweetIndex-1].likes.push(msg.sender);
        Tweet_info[User][TweetIndex-1].LikesCount++;
    }




}
