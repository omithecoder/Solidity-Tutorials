// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Here in Twitter 0.5v 
// In this version we adding some new elements to make the all process more smoother 
// Here first we adding 'Id' which specifies unique keyvalue for each and every tweet now tweet have there own identification 
// Id = value is nothing but the current length of Tweet_info array(map)
// secondly we adding unlike tweet feature 
// and some modification in liketweet fucntion 




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
    }

    function UnlikeTweet(address User,uint256 TweetIndex)external 
    CheckAlreadyLiked(User,TweetIndex) CheckAlreadyUnLiked(User,TweetIndex)
    {
        require(User != msg.sender,"This is Your Tweet!You cann't Like Your Tweet!");
        Tweet_info[User][TweetIndex-1].unlikes.push(msg.sender);
        Tweet_info[User][TweetIndex-1].unlikescount++;
        
    }




}
