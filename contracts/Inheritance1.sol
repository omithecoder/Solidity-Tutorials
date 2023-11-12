// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Inheritance in Solidity : Here Key concept of Inheritance is same as what is in any Object Oriented Programming Language or in our Biology 
// Means Inherit or aquiring character of parent 
// But here we inherit contracts 
// Here Inherited contracts can access the function as well variables of it's parent contract 
// But one condition is that those function and variables must have visibility as "Internal"

// that's all!

contract parent{

    string internal message;

    function ParentMessage(string memory editmessage)internal 
    {
        message = editmessage;
    }

    function ParentName()internal pure returns (string memory)
    {
        string memory Message;
        Message = "Hii I am Your parent John";
        return Message;
        
    }

}

contract child is parent{


    function Editparentmessage(string memory editmessage)public 
    {
        ParentMessage(editmessage);

    }

    function getmessage()public view  returns (string memory)
    {
        return message;
    }

    function callParentName()public pure returns(string memory)
    {
        return ParentName();
    }

}