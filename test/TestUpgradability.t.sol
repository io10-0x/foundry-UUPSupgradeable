//SDPX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "../lib/forge-std/src/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {Test, console} from "../lib/forge-std/src/Test.sol";
import {DeployBoxV1} from "../script/DeployBoxV1.s.sol";

contract TestUpgradability is Test {
    BoxV1 public proxy;
    DeployBoxV1 public deployBoxV1;
    address user1 = vm.addr(1);

    function setUp() public {
        deployBoxV1 = new DeployBoxV1();
        address proxyAddress = deployBoxV1.run();
        proxy = BoxV1(proxyAddress);
    }

    function test_proxyupgradeworks() public {
        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        BoxV2 boxv2 = new BoxV2();
        console.log(proxy.owner());
        proxy.upgradeToAndCall(address(boxv2), "");
        vm.stopPrank();

        assertEq(proxy.version(), 2);
    }
}
