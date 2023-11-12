// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract CalculateAllExpenses{

    uint256 public TotalExpense=0;
    uint256[] All_Expenses;

    function AddExpenses(uint256 Expense) public
    {
        All_Expenses.push(Expense);
        TotalExpense = TotalExpense + Expense;

    }

    function Get_All_Expense() public view returns (uint256[] memory)
    {
        return All_Expenses;
    }

}