// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Here in Twitter 0.6v 
// Here we are adding Notification Fucntionality for completion of specific task using Events in solidity

// We are Creating events for 1)CreateTweet & 2)LikeTweat function 
// so that anybody created any Tweet or Like any Tweet this get notify to all users who are using this smart contract




contract Twitter
{
    address owner;
    // defining Structure
    struct Tweet
    {
        uint256 id;
        string content;
        address author;
        uint256 timestamp;
        address[] likes;
        uint256 LikesCount;
        uint256 unlikescount;
        address[] unlikes;
    } 

    constructor()
    {
        owner = msg.sender;
    }

    // Events
    // CreateTweet Event
    event TweetCreated(uint256 id,address author,string content,uint256 timestamp);
    // Like Tweet Event
    event TweetLiked(address liker,address author,uint256 likecount,uint256 id);

    uint256 TweetLength = 10;

    modifier isOwner()
    {
        require(owner == msg.sender,"You are not a Owner!Permission Denied!");
        _;
    }

    function ChangeTweetLength(uint256 newTweetLen)public isOwner{
        TweetLength = newTweetLen;
    }


    address[] li;
    mapping (address => Tweet[]) Tweet_info;
    function createTweet(string memory _tweet) public {
        // Here we use Memory Because We tell Solidity that When this structure is created we save this in temp memory as function exection done then we remove this memory

        // Here We are adding String Length limit 
        // Note : Here we cannot find string length directly using string_name.length instead of that we suppose tto first convert the string into bytes and then we find the length of that bytes string using bytes(string_name).length 
        
        require(bytes(_tweet).length <= TweetLength ,"Tweet Length is Exceed!");

        Tweet memory NewTweet = Tweet({
            id : Tweet_info[msg.sender].length+1,
            content:_tweet,
            author:msg.sender,
            timestamp:block.timestamp,
            likes:li,
            LikesCount:0,
            unlikescount:0,
            unlikes:li
        });

        Tweet_info[msg.sender].push(NewTweet);
        emit TweetCreated(Tweet_info[msg.sender].length+1, msg.sender, _tweet, block.timestamp);
    }

    // Modifiers 
    // This modifiers check wheather user already liked or unliked the twitter before liking and unliking tweet
    modifier CheckAlreadyLiked(address User,uint256 id)
    {
        require(Tweet_info[User].length >= id,"This Tweet Not Exist !");
        bool res = true;
        uint256 l = 0;
        while (l<Tweet_info[User][id-1].likes.length)
        {
            if(Tweet_info[User][id-1].likes[l] == msg.sender)
            {
                res=false;
                break;
            }
            else {
            l++;
            }
        }

        require(res == true, "You Already Liked the tweet!");
        _;

    }

    modifier CheckAlreadyUnLiked(address User,uint256 id)
    {
       require(Tweet_info[User].length >= id,"This Tweet Not Exist !");
        bool res = true;
        uint256 l =0;
        while (l<Tweet_info[User][id-1].likes.length)
        {
            if(Tweet_info[User][id-1].unlikes[l] == msg.sender)
            {
                res=false;
                break;
            }
            l++;
        }

        require(res == true,"You Already UnLiked the tweet!");
        _;

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

    function LikesTweet(address User,uint256 TweetIndex)external 
    CheckAlreadyLiked(User,TweetIndex) CheckAlreadyUnLiked(User,TweetIndex)
    {
        require(User != msg.sender,"This is Your Tweet!You cann't Like Your Tweet!");
        Tweet_info[User][TweetIndex-1].likes.push(msg.sender);
        Tweet_info[User][TweetIndex-1].LikesCount++;
        emit TweetLiked(msg.sender , User, Tweet_info[User][TweetIndex-1].LikesCount, Tweet_info[User][TweetIndex-1].id);   
    }

    function UnlikeTweet(address User,uint256 TweetIndex)external 
    CheckAlreadyLiked(User,TweetIndex) CheckAlreadyUnLiked(User,TweetIndex)
    {
        require(User != msg.sender,"This is Your Tweet!You cann't Like Your Tweet!");
        Tweet_info[User][TweetIndex-1].unlikes.push(msg.sender);
        Tweet_info[User][TweetIndex-1].unlikescount++;
        
    }




}
