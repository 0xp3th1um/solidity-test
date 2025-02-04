// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

interface ERC20Like {
    function balanceOf(address) external returns (uint256);
    function approve(address usr, uint256 wad) external returns (bool);
}

interface CoinLike {
    function usd() external view returns (address);
    function eur() external view returns (address);
    function coin(address, uint256) external;
}

contract DeepStack {
    address public immutable bow;
    ERC20Like public immutable usd;
    ERC20Like public immutable eur;
    CoinLike public immutable usdCoin;
    CoinLike public immutable eurCoin;

    event Bow(address indexed token, uint256 amount);

    constructor(address usdCoin_, address eurCoin_, address bow_) {
        usdCoin = CoinLike(usdCoin_);
        usd = ERC20Like(usdCoin.usd());
        eurCoin = CoinLike(eurCoin_);
        eur = ERC20Like(eurCoin.eur());
        bow = bow_;
        usd.approve(usdCoin_, type(uint256).max);
        eur.approve(eurCoin_, type(uint256).max);
    }

    function whistle() public {
        uint256 usdBalance = usd.balanceOf(address(this));
        if (usdBalance > 0) {
            usdCoin.coin(bow, usdBalance);
            emit Bow(address(usd), usdBalance);
        }
        uint256 eurBalance = eur.balanceOf(address(this));
        if (eurBalance > 0) {
            eurCoin.coin(bow, eurBalance);
            emit Bow(address(eur), eurBalance);
        }
    }
}
