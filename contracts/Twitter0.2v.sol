// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Here in this Twitter0.2v we are adding structure for a tweet of user because we know tweet comes with lots of data like main content,timestamp,author,likes,unlikes etc all of this is easily store into the structure so we are creating that one in this 

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
    address[] li;
    mapping (address => Tweet[]) Tweet_info;
    function createTweet(string memory _tweet) public {
        // Here we use Memory Because We tell Solidity that When this structure is created we save this in temp memory as function exection done then we remove this memory

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