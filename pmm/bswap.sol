// SPDX-License-Identifier: MIT

/*

    Copyright 2020 BSWAP FACTORY.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

import {Types} from "./library/Types.sol";
import {IERC20} from "./interface/IERC20.sol";
import {Storage} from "./implementation/Storage.sol";
import {Trader} from "./implementation/Trader.sol";
import {LiquidityProvider} from "./implementation/LiquidityProvider.sol";
import {Admin} from "./implementation/Admin.sol";
import {BSWAPLpToken} from "./implementation/BSWAPLpToken.sol";


/**
 * @title BSWAP
 * @author BSWAP Breeder
 *
 * @notice Entrance for users
 */
contract BSWAP is Admin, Trader, LiquidityProvider {
    function init(
        address owner,
        address supervisor,
        address maintainer,
        address baseToken,
        address quoteToken,
        address oracle,
        uint256 lpFeeRate,
        uint256 mtFeeRate,
        uint256 k,
        uint256 gasPriceLimit
    ) external {
        require(!_INITIALIZED_, "BSWAP_INITIALIZED");
        _INITIALIZED_ = true;

        // constructor
        _OWNER_ = owner;
        emit OwnershipTransferred(address(0), _OWNER_);

        _SUPERVISOR_ = supervisor;
        _MAINTAINER_ = maintainer;
        _BASE_TOKEN_ = baseToken;
        _QUOTE_TOKEN_ = quoteToken;
        _ORACLE_ = oracle;

        _DEPOSIT_BASE_ALLOWED_ = false;
        _DEPOSIT_QUOTE_ALLOWED_ = false;
        _TRADE_ALLOWED_ = false;
        _GAS_PRICE_LIMIT_ = gasPriceLimit;

        // Advanced controls are disabled by default
        _BUYING_ALLOWED_ = true;
        _SELLING_ALLOWED_ = true;
        uint256 MAX_INT = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        _BASE_BALANCE_LIMIT_ = MAX_INT;
        _QUOTE_BALANCE_LIMIT_ = MAX_INT;

        _LP_FEE_RATE_ = lpFeeRate;
        _MT_FEE_RATE_ = mtFeeRate;
        _K_ = k;
        _R_STATUS_ = Types.RStatus.ONE;

        _BASE_CAPITAL_TOKEN_ = address(new BSWAPLpToken(_BASE_TOKEN_));
        _QUOTE_CAPITAL_TOKEN_ = address(new BSWAPLpToken(_QUOTE_TOKEN_));

        _checkBSWAPParameters();
    }
}
