/*

    Copyright 2020 BSWAP FACTORY.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

interface IBPPAdmin {
    function init(address owner, address bpp,address operator, address bswapSmartApprove) external;
}