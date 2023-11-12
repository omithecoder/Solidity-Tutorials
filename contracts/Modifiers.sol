//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Modifiers : this are nothing but small functions containing a logic related to some conditions/requirements this are also work as conditionals like if-else in solidity 
// But main usecase is to give conditions / check condition to run a specific function 

// In Solidity, a modifier is a way to encapsulate reusable code that can be applied to multiple functions within a contract. Modifiers are often used to enforce access control, validate inputs, or perform certain checks before allowing a function to execute. They help in making the contract code more modular, readable, and easier to maintain.



contract ModifierExample
{

   uint256 Transaction_Cost = 100;
   address owner;
   struct Account
   {
    address user;
    uint256 balance;
   }


//    Here constructor only calls when this contract first deploy on the chain means it only runs one time when a owner of this contract deploy it on chain


   constructor()
   {
    owner = msg.sender;
   }


   mapping (address => Account) accounts;
   function CreateAccount()public 
   {
    accounts[msg.sender].user = msg.sender;
    accounts[msg.sender].balance = 500;
   }

   function Transfer(address user,uint256 amount)public 
   {
    // Require condition  = Sender should have minimum balance = amount+transaction_cost
    require(accounts[msg.sender].balance >= amount+Transaction_Cost,"Not Have Sufficient money for this Transaction!");
    accounts[user].balance +=amount;
    accounts[msg.sender].balance -=amount;
   }

   function GetMyBalance() public view returns(uint256)
   {
    return accounts[msg.sender].balance;
   }

//    Modifier
modifier isOwner()
{
    require(owner == msg.sender,"You are Not a Owner of This Contract!");
    _;
}

   function Change_TransCost(uint256 newTransCost)public isOwner{
    Transaction_Cost = newTransCost;
   }



}