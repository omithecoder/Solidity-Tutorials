// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Here in Twitter 0.7v we are adding one more feature to count total number of likes or unlikes of a individual User
// This is done by using loops and iterating all the tweets of a author




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
    modifier CheckAlreadyLiked(address User, uint256 id) {
    bool res = true;  // Initialize res to true
    require(Tweet_info[User].length >= id, "This Tweet Not Exist !");

    for (uint256 l = 0; l < Tweet_info[User][id-1].likes.length; l++) {
        if (Tweet_info[User][id-1].likes[l] == msg.sender) {
            res = false;
            break;
        }
    }

    require(res == true, "You Already Liked the tweet!");
    _;
}

modifier CheckAlreadyUnLiked(address User, uint256 id) {
    bool res = true;  // Initialize res to true
    require(Tweet_info[User].length >= id, "This Tweet Not Exist !");

    for (uint256 l = 0; l < Tweet_info[User][id-1].unlikes.length; l++) {
        if (Tweet_info[User][id-1].unlikes[l] == msg.sender) {
            res = false;
            break;
        }
    }

    require(res == true, "You Already UnLiked the tweet!");
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

    function getTotalLikes(address author) view  external returns (uint256) 
    {
       uint256 TotalLikes = 0;

        for(uint256 i=0;i<Tweet_info[author].length;i++)
        {
            TotalLikes = TotalLikes + Tweet_info[author][i].LikesCount;
        }

        return TotalLikes;

        
    }

    function getTotalUnLikes(address author) view  external returns (uint256) 
    {
        uint256 TotalUnlikes = 0;

        for(uint256 i=0;i<Tweet_info[author].length;i++)
        {
            TotalUnlikes = TotalUnlikes + Tweet_info[author][i].unlikescount;
        }

        return TotalUnlikes;

        
    }




}
