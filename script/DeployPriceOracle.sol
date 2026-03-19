// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {PriceOracle} from "../src/Oracle/PriceOracle.sol";
import {Script, console} from "forge-std/Script.sol";
import {
    ScriptForPriceOracle
} from "../script/Helper/ScriptForPriceOracle.s.sol";
import {mockRouter} from "../test/mock/mockRouter.sol";
import {IPriceOracle} from "../src/Oracle/IPriceOracle.sol";

contract DeployPriceOracle is Script {
    PriceOracle public s_priceOracle;
    ScriptForPriceOracle public s_scriptPriceOracle;
    mockRouter public s_mockRouter;
    function run(address accessControlAddr) public returns (PriceOracle) {
        s_scriptPriceOracle = new ScriptForPriceOracle();
        IPriceOracle.RequestData memory network = s_scriptPriceOracle
            .getNetworkConfig();
        vm.startBroadcast();
        if (block.chainid == 31337) {
            s_mockRouter = new mockRouter();
            network.router = address(s_mockRouter);
            network.accessControlAddress = address(accessControlAddr);
        }
        s_priceOracle = new PriceOracle(msg.sender, network);
        vm.stopBroadcast();
        console.log(
            "The address of the PriceOracle : ",
            address(s_priceOracle)
        );
        return s_priceOracle;
    }
}
