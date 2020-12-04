// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.6.0 <0.8.0;

contract SalesContract {
    event bought(address sender, uint amount);
    
    address payable _owner;
    address _pear;
    address _steak;
    
    bool _stopped = false;
    
    constructor () public {
        _owner = tx.origin;
    }
    
    /*
     *
     */    
    function buyTokens() external payable returns(uint) {
        require(_stopped == false, "Sales are no longer active!");
        uint amount = msg.value * 1000;
        
        _owner.transfer(address(this).balance);
        
        (bool success, bytes memory returnData) = address(_pear).call(abi.encodeWithSignature("mint(address,uint256)",msg.sender, amount));
        require(success);
        
        (success, returnData) = address(_steak).call(abi.encodeWithSignature("mint(address,uint256)",msg.sender, amount));
        require(success);
        emit bought(msg.sender, amount);
    }
    
    /*
     *
     */
    function setPear(address pear_) public {
        require(msg.sender == _owner, "Only owner can set pear!");
        _pear = pear_;
    }
    
    /*
     *
     */
    function setSteak(address steak_) public {
        require(msg.sender == _owner, "Only owner can set steak!");
        _steak = steak_;
    }
    
    /*
     *
     */
    function stopSaled(bool stopped_) public {
        require(msg.sender == _owner, "Only owner can stop sales!");
        _stopped = stopped_;
    }
}
