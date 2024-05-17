// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployToken} from "../script/DeployToken.s.sol";
import {OurToken} from "../src/OurToken.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract OurTokenTest is StdCheats, Test {
    uint256 BOB_STARTING_AMOUNT = 100 ether;

    OurToken public ourToken;
    DeployToken public deployer;
    address public deployerAddress;
    address bob;
    address alice;

    function setUp() public {
        deployer = new DeployToken();
        ourToken = deployer.run();

        bob = makeAddr("bob");
        alice = makeAddr("alice");

        deployerAddress = vm.addr(deployer.deployerKey());
        vm.prank(deployerAddress);
        ourToken.transfer(bob, BOB_STARTING_AMOUNT);
    }

    function testInitialSupply() public view {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(ourToken)).mint(address(this), 1);
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Alice approves Bob to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);
        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);
        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT - transferAmount);
    }

    // can you get the coverage up?
}













































































































// pragma solidity ^0.8.18;

// import {Test} from "forge-std/Test.sol";

// import {DeployToken} from "../script/DeployToken.s.sol";

// import {OurToken} from "../src/OurToken.sol";

// contract OurTokenTest is Test {
//     OurToken public ourToken;
//     DeployToken public deployer;

//     address bob = makeAddr("bob");
//     address noob = makeAddr("noob");

//     uint256 public constant STARTING_BALANCE = 100 ether;

//     function setUp() public {
//         deployer = new DeployToken();
//         ourToken = deployer.run();
//         vm.prank(msg.sender);
//         ourToken.transfer(bob, STARTING_BALANCE);
//     }

//     function testBobBalance() public view {
//         assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
//     }

//     function testAllowancesWorks() public  {
//         uint256 INITIAL_ALLOWANCE = 1000;
//         // Bob approves noob to spend tokens on his behalf
//         vm.prank(bob);
//         ourToken.approve(noob, INITIAL_ALLOWANCE);

//         uint256 transferAmount = 500;

//         vm.prank(noob);
//         ourToken.transferFrom(bob, noob, transferAmount);

//         assertEq(ourToken.balanceOf(noob), transferAmount);
//         assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);

//     }


// }