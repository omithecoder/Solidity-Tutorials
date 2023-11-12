// SPDX-License-Identifier: MIT

// Here in Twitter 0.8v we are replace our modifier "isOwner()" (Ownerable Contract) with a standard Ownable Contract from Openzeppelin (repo-Library for Secure Smart Contract) => Ownable.sol

// GitRepo = https://github.com/OpenZeppelin/openzeppelin-contracts.git

import "@openzeppelin/contracts/access/Ownable.sol";
pragma solidity ^0.8.20;

interface IProfile {
    struct UserProfile {
        string displayName;
        string bio;
    }
    
    // CODE HERE

    function getProfile (address _user) external view returns (UserProfile memory);
}

contract Twitter is Ownable {

    IProfile profileContract;

    constructor(address _profileContract) Ownable(msg.sender) {
        profileContract = IProfile(_profileContract);
    }
   
    // defining Structure
    struct Tweet {
        uint256 id;
        string content;
        address author;
        uint256 timestamp;
        address[] likes;
        uint256 LikesCount;
        uint256 unlikescount;
        address[] unlikes;
    }
    

    // Now No Need of this constructor

    // Events
    // CreateTweet Event
    event TweetCreated(
        uint256 id,
        address author,
        string content,
        uint256 timestamp
    );
    // Like Tweet Event
    event TweetLiked(
        address liker,
        address author,
        uint256 likecount,
        uint256 id
    );

    // check wheather user is registered or not 

    modifier onlyRegistered(){
        IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);
        require(bytes(userProfileTemp.displayName).length > 0, "USER NOT REGISTERED");
        _;
    }
     

    uint256 TweetLength = 10;

    function ChangeTweetLength(uint256 newTweetLen) public onlyOwner{
        TweetLength = newTweetLen;
    }

    address[] li;
    mapping(address => Tweet[]) Tweet_info;


    function createTweet(string memory _tweet) public onlyRegistered {
        // Here we use Memory Because We tell Solidity that When this structure is created we save this in temp memory as function exection done then we remove this memory

        // Here We are adding String Length limit
        // Note : Here we cannot find string length directly using string_name.length instead of that we suppose tto first convert the string into bytes and then we find the length of that bytes string using bytes(string_name).length

        require(bytes(_tweet).length <= TweetLength, "Tweet Length is Exceed!");

        Tweet memory NewTweet = Tweet({
            id: Tweet_info[msg.sender].length + 1,
            content: _tweet,
            author: msg.sender,
            timestamp: block.timestamp,
            likes: li,
            LikesCount: 0,
            unlikescount: 0,
            unlikes: li
        });

        Tweet_info[msg.sender].push(NewTweet);
        emit TweetCreated(
            Tweet_info[msg.sender].length + 1,
            msg.sender,
            _tweet,
            block.timestamp
        );
    }

    // Modifiers
    // This modifiers check wheather user already liked or unliked the twitter before liking and unliking tweet
    modifier CheckAlreadyLiked(address User, uint256 id) {
        bool res = true; // Initialize res to true
        require(Tweet_info[User].length >= id, "This Tweet Not Exist !");

        for (uint256 l = 0; l < Tweet_info[User][id - 1].likes.length; l++) {
            if (Tweet_info[User][id - 1].likes[l] == msg.sender) {
                res = false;
                break;
            }
        }

        require(res == true, "You Already Liked the tweet!");
        _;
    }

    modifier CheckAlreadyUnLiked(address User, uint256 id) {
        bool res = true; // Initialize res to true
        require(Tweet_info[User].length >= id, "This Tweet Not Exist !");

        for (uint256 l = 0; l < Tweet_info[User][id - 1].unlikes.length; l++) {
            if (Tweet_info[User][id - 1].unlikes[l] == msg.sender) {
                res = false;
                break;
            }
        }

        require(res == true, "You Already UnLiked the tweet!");
        _;
    }

    function GetAllTweets() public view returns (Tweet[] memory) {
        return Tweet_info[msg.sender];
    }

    function GetTweet(address User, uint256 Index)
        public
        view
        returns (Tweet memory)
    {
        return Tweet_info[User][Index - 1];
    }

    function DeleteRecentTweet() public {
        Tweet_info[msg.sender].pop();
    }

    function DeleteAllTweets() public {
        delete Tweet_info[msg.sender];
    }

    function LikesTweet(address User, uint256 TweetIndex)
        external onlyRegistered
        CheckAlreadyLiked(User, TweetIndex)
        CheckAlreadyUnLiked(User, TweetIndex)
    {
        require(
            User != msg.sender,
            "This is Your Tweet!You cann't Like Your Tweet!"
        );
        Tweet_info[User][TweetIndex - 1].likes.push(msg.sender);
        Tweet_info[User][TweetIndex - 1].LikesCount++;
        emit TweetLiked(
            msg.sender,
            User,
            Tweet_info[User][TweetIndex - 1].LikesCount,
            Tweet_info[User][TweetIndex - 1].id
        );
    }

    function UnlikeTweet(address User, uint256 TweetIndex)
        external onlyRegistered
        CheckAlreadyLiked(User, TweetIndex)
        CheckAlreadyUnLiked(User, TweetIndex)
    {
        require(
            User != msg.sender,
            "This is Your Tweet!You cann't Like Your Tweet!"
        );
        Tweet_info[User][TweetIndex - 1].unlikes.push(msg.sender);
        Tweet_info[User][TweetIndex - 1].unlikescount++;
    }

    function getTotalLikes(address author) external view returns (uint256) {
        uint256 TotalLikes = 0;

        for (uint256 i = 0; i < Tweet_info[author].length; i++) {
            TotalLikes = TotalLikes + Tweet_info[author][i].LikesCount;
        }

        return TotalLikes;
    }

    function getTotalUnLikes(address author) external view returns (uint256) {
        uint256 TotalUnlikes = 0;

        for (uint256 i = 0; i < Tweet_info[author].length; i++) {
            TotalUnlikes = TotalUnlikes + Tweet_info[author][i].unlikescount;
        }

        return TotalUnlikes;
    }
}
