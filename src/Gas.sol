// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

contract GasContract {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public whitelist;
    mapping(address => uint256) private whiteListStruct;
    address[5] public administrators;

    event WhiteListTransfer(address indexed);
    event AddedToWhitelist(address userAddress, uint256 tier);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        // Set the balance of the deployer to the total supply
        balances[msg.sender] = _totalSupply;

        // Use assembly to set the administrators array
        assembly {
            // Get the pointer to the administrators storage slot
            let slot := administrators.slot

            // Loop over the _admins array and set the administrators
            for {
                let i := 0
            } lt(i, 5) {
                i := add(i, 1)
            } {
                // Calculate the storage slot for the current index
                let adminSlot := add(slot, i)
                // Get the address from the _admins array
                let admin := mload(add(add(_admins, 0x20), mul(i, 0x20)))
                // Store the address in the administrators array
                sstore(adminSlot, admin)
            }
        }
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
        // Use assembly to iterate through the administrators array
        assembly {
            let slot := administrators.slot
            admin_ := 0
            for {
                let i := 0
            } lt(i, 5) {
                i := add(i, 1)
            } {
                let adminSlot := add(slot, i)
                if eq(sload(adminSlot), _user) {
                    admin_ := 1
                    break
                }
            }
        }
    }

    function balanceOf(address _user) public view returns (uint256) {
        return balances[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata
    ) public {
        unchecked {
            balances[msg.sender] -= _amount;
            balances[_recipient] += _amount;
        }
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        if (checkForAdmin(msg.sender) && _tier < 255) {
            emit AddedToWhitelist(_userAddrs, _tier);
        } else {
            revert();
        }
    }

    function whiteTransfer(address _recipient, uint256 _amount) public {
        whiteListStruct[msg.sender] = _amount;
        unchecked {
            balances[msg.sender] -= _amount;
            balances[_recipient] += _amount;
        }
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(
        address sender
    ) public view returns (bool, uint256) {
        return (true, whiteListStruct[sender]);
    }
}
