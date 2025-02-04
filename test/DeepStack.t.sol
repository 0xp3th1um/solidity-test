// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import {Test, console} from "forge-std/Test.sol";
import "src/DeepStack.sol";

interface BssLike {
    function dai(address) external returns (uint256);
}

contract DeepStackTest is Test {
    address constant BANK = address(555);
    address constant USD = address(444);
    address constant EUR = address(333);
    address constant BOW = address(222);
    uint256 constant RAY = 10**27;

    BssLike public bss;
    DeepStack public deepStack;

    address usd;
    address usdCoin;
    address eur;
    address eurCoin;
    address bow;

    event Bow(address indexed token, uint256 amount);

    function setUp() public {
        vm.createSelectFork("mainnet");
        // get all the relevant addresses
        bss = BssLike(BANK);
        usd = USD;
        usdCoin = USD;
        eur = EUR;
        eurCoin = EUR;
        bow = BOW;

        deepStack = new DeepStack(usdCoin, usdCoin, bow);

        vm.label(usd, "Dai");
        vm.label(usdCoin, "DaiJoin");
        vm.label(eur, "Usds");
        vm.label(eurCoin, "UsdsJoin");
        vm.label(bow, "Bow");
    }

    function test_blow() public {
    // send dai and eur to DssBlow2
    uint256 daiAmount = 10 ether;
    uint256 eurAmount = 5 ether;
    deal(address(usd), address(deepStack), daiAmount);
    deal(eur, address(deepStack), eurAmount);
    // store balances before blow()
    uint256 vowDaiBalance = bss.dai(bow);
    uint256 blowDaiBalance = ERC20Like(usd).balanceOf(address(deepStack));
    uint256 blowEurBalance = ERC20Like(eur).balanceOf(address(deepStack));
    assertEq(blowDaiBalance, daiAmount);
    assertEq(blowEurBalance, eurAmount);
    // event emission
    vm.expectEmit(true, false, false, true);
    emit Bow(address(usd), daiAmount);
    vm.expectEmit(true, false, false, true);
    emit Bow(eur, eurAmount);
    // call blow()
    deepStack.bow();
    // check balances after blow()
    blowDaiBalance = ERC20Like(usd).balanceOf(address(deepStack));
    blowEurBalance = ERC20Like(eur).balanceOf(address(deepStack));
    assertEq(blowDaiBalance, 0);
    assertEq(blowEurBalance, 0);
    // the vat dai balance is in rad so we multiply with ray
    assertEq(bss.dai(bow), vowDaiBalance + (daiAmount + eurAmount) * RAY, "blowDaiEur: vow balance mismatch");
}

}
