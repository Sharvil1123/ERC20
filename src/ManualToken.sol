// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract ManualToken{
    //abi

    mapping(address => uint256) private s_balances;

    function name() public pure returns(string memory) {
        return "SHAB Token";
    }

    function totalSupply() public pure returns(uint256){
        return 1000 ether;
    }

    function decimals() public pure returns(uint8){
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256){
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public {
        uint256 prevBalance = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _amount
        s_balances[_to] += _amount;
        require(balanceOf(msg.sender) + balanceOf(_to) == prevBalance);
    }

}