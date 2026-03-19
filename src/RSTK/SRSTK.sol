// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {IRSTKToken} from "../RSTK/token/IRSTKToken.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";
import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/FunctionsClient.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/libraries/FunctionsRequest.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {IContractStruct} from "./IContractStruct.sol";
import {IRWAAccessControl} from "../access/IRWAAccessControl.sol";
import {IPriceOracle} from "../Oracle/IPriceOracle.sol";

contract SRSTK is FunctionsClient, ConfirmedOwner, AggregatorV3Interface, IContractStruct {
    /*//////////////////////////////////////////////////////////////
                            TYPE DECLERATION
    //////////////////////////////////////////////////////////////*/
    using FunctionsRequest for FunctionsRequest.Request;
    /*//////////////////////////////////////////////////////////////
                             STATE VARIABLE
    //////////////////////////////////////////////////////////////*/
    IRWAAccessControl public immutable i_rwaAccessControl;
    uint64 immutable i_subscriptionId;
    uint256 private s_portfolioBalance;
    address immutable i_usdcUSD;
    address immutable i_tokenOnSepolia;
    bytes32 immutable i_donId;
    uint32 immutable i_gasLimit;
    uint256 immutable i_precision;
    

    constructor(IPriceOracle.RequestData memory config) FunctionsClient(config.router) ConfirmedOwner(i_rwaAccessControl.owner()) {
        i_subscriptionId = config.subscriptionId;
        i_donId = config.donId;
        i_gasLimit = config.gas_limit;
       
    function sendMintRequest() public {}

    function sendBurnRequest() public {}

    function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal override {}

}
