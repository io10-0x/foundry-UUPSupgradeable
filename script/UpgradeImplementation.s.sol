//SDPX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "../lib/forge-std/src/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeImplementation is Script {
    function run() public returns (address) {
        address proxyaddress = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
        );
        vm.startBroadcast();
        BoxV2 boxv2 = new BoxV2();
        vm.stopBroadcast();
        address proxy = upgradeimplementation(address(boxv2), proxyaddress);
        return proxy;
    }

    function upgradeimplementation(
        address upgradedcontract,
        address proxyaddress
    ) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyaddress);
        proxy.upgradeToAndCall(upgradedcontract, "");
        vm.stopBroadcast();
        return address(proxy);
    }
}
