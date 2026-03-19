// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IContractStruct {
    struct Depositor {
        address depositorAddress;
        uint256 amountDepositedMinusFees;
        uint256 priceId;
    }

    struct Redeemer {
        address user;
        uint256 amountToTokenBurned;
        uint256 priceId;
    }

    struct 
}
