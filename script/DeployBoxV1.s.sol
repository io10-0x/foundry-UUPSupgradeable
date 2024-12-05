//SDPX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract DeployBoxV1 is Script {
    function run() public returns (address) {
        vm.startBroadcast();
        BoxV1 boxv1 = new BoxV1();
        bytes memory data = abi.encodeWithSignature("initialize()");
        ERC1967Proxy proxy = new ERC1967Proxy(address(boxv1), data);

        vm.stopBroadcast();
        return address(proxy);
    }
}
