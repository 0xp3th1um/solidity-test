// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {DeepStack} from "../src/DeepStack.sol";

contract DeepStackScript is Script {
    DeepStack public deepStack;

    address constant usd = address(1);
    address constant eur = address(2);
    address constant bow = address(3);

    function run() public {
        vm.startBroadcast();

        deepStack = new DeepStack(usd, eur, bow);

        vm.stopBroadcast();
    }
}
