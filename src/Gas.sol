// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.26;

contract GasContract {
    struct ImportantStruct {
        uint256 amount;
        bool paymentStatus;
    }

    mapping(address => uint256) public balances;
    mapping(address => uint256) public whitelist;
    mapping(address => ImportantStruct) private whiteListStruct;
    address[5] public administrators;

    event WhiteListTransfer(address indexed);
    event AddedToWhitelist(address userAddress, uint256 tier);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        balances[msg.sender] = _totalSupply;

        for (uint256 i = 0; i < 5; i++) {
            administrators[i] = _admins[i];
        }
    }

    function addToWhitelist(address _user, uint256 _tier) public {
        require(checkForAdmin(msg.sender) && _tier < 255);
        uint256 finalTier = _tier > 3 ? 3 : _tier;
        assembly {
            sstore(add(whitelist.slot, _user), finalTier)
        }
        emit AddedToWhitelist(_user, _tier);
    }

    function balanceOf(address _user) public view returns (uint256) {
        return balances[_user];
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
        for (uint256 ii = 0; ii < 5; ii++) {
            if (administrators[ii] == _user) {
                admin_ = true;
            }
        }
        return admin_;
    }

    function getPaymentStatus(
        address sender
    ) external view returns (bool, uint256) {
        return (
            whiteListStruct[sender].paymentStatus,
            whiteListStruct[sender].amount
        );
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
    }

    function whiteTransfer(address _recipient, uint256 _amount) external {
        uint256 tier = whitelist[msg.sender];
        uint256 balance = balances[msg.sender];
        balances[msg.sender] = balance - _amount + tier;
        balances[_recipient] = balances[_recipient] + _amount - tier;
        whiteListStruct[msg.sender].amount = _amount;
        whiteListStruct[msg.sender].paymentStatus = true;

        emit WhiteListTransfer(_recipient);
    }
}
