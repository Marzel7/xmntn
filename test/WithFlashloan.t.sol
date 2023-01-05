pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WithFlashloan.sol";
import "forge-std/console.sol";

contract WithFlashloanTest is Test {
    using stdStorage for StdStorage;

    WithFlashloan public attacker;

    uint256 mainnetfork;

    string MAINNET_RPC_URL =
        "https://eth-mainnet.g.alchemy.com/v2/bcgSkno6kneI9GfrazJAmYHODzdO6VbE";

    function setUp() public {
        mainnetfork = vm.createFork(MAINNET_RPC_URL);
    }

    function testRun() public {
        vm.selectFork(mainnetfork);
        vm.rollFork(15598022); // Before the report submitted
        attacker = new WithFlashloan();
        attacker.run();
    }
}
