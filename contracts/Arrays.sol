// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Arrays in Solidity : Arrays in solidity are as same as Arrays in other Programming Languages They are storage of similar datatype in consecutive memory Location 

contract Array
{
    // Initialization of some Dynamic Arrays 
    // uint[] public arr;
    // uint[] public arr1 = [1,2,3];

    // // Initialisation of Fixed size arrays
    // uint[5] Arr;
    // uint[3] Arr1 = [1,2,3];
    // string[2] names = ["omkar","soham"];

    uint256[] array;

    function Push(uint256 num)public 
    {
        array.push(num);
    }

    function Pop() public 
    {
        array.pop();
    }

    function GetArrayLength()public view returns (uint256)
    {
        return array.length;
    }

    function GetArray()public view returns (uint256[] memory)
    {
        return array;
    }

    function DeleteAll()public 
    {
        delete array;
    }


}