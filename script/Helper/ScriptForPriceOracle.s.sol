// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";
import {IPriceOracle} from "../../src/Oracle/IPriceOracle.sol";
import {RWAAccessControl} from "../../src/access/RWAAccessControl.sol";
contract ScriptForPriceOracle is Script {
    IPriceOracle.RequestData public s_config;
    RWAAccessControl public s_accessControl;
    error ScriptForPriceOracle__InvalidNetwork();

    mapping(uint256 => IPriceOracle.RequestData) public s_networks;
    
    constructor() {
        if (block.chainid == 11155111) {
            s_networks[block.chainid] = getSepoliaConfig();
        } else if (block.chainid == 31337) {
            s_networks[block.chainid] = getAnvilConfig();
        } else {
            revert ScriptForPriceOracle__InvalidNetwork();
        }
    }

    function getNetworkConfig()
        external
        view
        returns (IPriceOracle.RequestData memory)
    {
        return s_networks[block.chainid];
    }

    function getSepoliaConfig()
        public
        pure
        returns (IPriceOracle.RequestData memory sepoliaConfig)
    {
        sepoliaConfig = IPriceOracle.RequestData({
            source: "./functions/sources/source.js",
            donHostedSecretsSlotID: 0,
            donHostedSecretsVersion: 1773909506,
            args: new string[](0),
            bytesArgs: new bytes[](0),
            subscriptionId: 6299,
            gasLimit: 300_000,
            donID: hex"66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000",
            router: 0xb83E47C2bC239B3bf370bc41e1459A34b41238D0,
            accessControlAddress: 0x8E0f7731485F2086f5e1F9B9a6D401D3d4b57770
        });
    }

    function getAnvilConfig()
        public
        view
        returns (IPriceOracle.RequestData memory)
    {
        return
            IPriceOracle.RequestData({
                router: address(0),
                accessControlAddress: address(0),
                source: "return 100",
                donHostedSecretsSlotID: 0,
                donHostedSecretsVersion: 0,
                args: new string[](0),
                bytesArgs: new bytes[](0),
                subscriptionId: 1,
                gasLimit: 300_000,
                donID: bytes32("fun-ethereum-sepolia-1")
        });
    }
}
