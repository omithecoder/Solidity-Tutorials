// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//Loops : Here loops in solidity are as same as loops in other programming language 
// there syntax is way close to c,c++ loops

contract TableContract {
    uint256[] table;
    function Table(uint256 number)public
    {
        delete table;
        for(uint256 i=1;i<=10;i++)
        {
            table.push(number * i);
        }
    }

    function GetTable() view public returns (uint256[] memory)
    {
        return table;
    }

}