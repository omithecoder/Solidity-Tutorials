// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Calculator{

    uint256 result = 0;

    // Solidity Function Syntax
    // function function_name(parameters) visibility(public/private/internal/external) return mode(view/pure) according to changes in contract return type(uint,string etc)
    function add(uint256 num1,uint256 num2) public 
    {
        result = num1 + num2;
        
    }

    function substract(uint256 num1,uint256 num2) public 
    {
        result = num1 - num2;
        
    }

    function multiply(uint256 num1,uint256 num2) public
    {
        result = num1 * num2;
        
    }
    function getresult()public view returns(uint256)
    {
        return result;
    }



    // When we deploy our contract on blockchain we understnad that for changing the data in the blockchain like here we are continuoulsy changint the result variable by performing various operations we wants to pay some gas fees but to get the data from block chain like to get reult we donot want to pay 



}