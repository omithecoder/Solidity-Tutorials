// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Requires => Are the conditionals in the solidity means they are use to make conditions/Conditional logic in solidity 

// If Condition is true then further part of code start running 
// But if the condition get false then contract revert or stop the execution of that function

contract RequireExample
{
    // Votting System
    uint256 public BJP;
    uint256 public AAP;
function VoteBJP(uint256 age)public {
     require(age>=18,"You Are Not Eligible!You Are Under 18");
            BJP++;
        }

        function VoteAAP(uint256 age)public {
             require(age>=18,"You Are Not Eligible!You Are Under 18");
            AAP++;
        }

    
    
    }
   
