// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract OldCal
{
    uint256 internal result = 0;

    function Add(uint256 num1,uint256 num2) public
    {
        result = num1 + num2;
    }


    function Substarct(uint256 num1, uint256 num2) public {
        result = num1-num2;
    }

    function GetResult() internal view returns (uint256)
    {
        return result;
    }

}

// Here NewCal is Inherited contract of OldCal contract so it can access all those fucntions and variables whose visibility is Internal 

// here result And GetResult are access by NewCal
contract NewCal is OldCal
{

    function multiply(uint256 num1,uint256 num2) public 
    {
        result = num1*num2;
    }

    function divide(uint256 num1,uint256 num2) public {
        result = num1/num2;
    }
    
    function GetAnswer()public view returns(uint256)
    {
        return GetResult();
    }

}