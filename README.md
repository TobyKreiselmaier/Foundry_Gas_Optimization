# GAS OPTIMSATION 

- Your task is to edit and optimise the Gas.sol contract. 
- You cannot edit the tests & 
- All the tests must pass.
- You can change the functionality of the contract as long as the tests pass. 
- Try to get the gas usage as low as possible. 



## To run tests & gas report with verbatim trace 
Run: `forge test --gas-report -vvvv`

## To run tests & gas report
Run: `forge test --gas-report`

## To run a specific test
RUN:`forge test --match-test {TESTNAME} -vvvv`
EG: `forge test --match-test test_onlyOwner -vvvv`

Result:

2,790,345 - original gas
2,659,266 / 131,079 (saved) - updated to solc 0.8.26
2,538,732 / 120,534 (saved) - removed ownable & context contracts
2,538,732 /       0 (saved) - removed constants contract
2,444,301 /  94,432 (saved) - removed redundant flags & getTradingMode()
2,408,903 /  35,398 (saved) - removed totalSupply from storage (not used)
2,399,481 /   9,422 (saved) - reduced visibility of paymentCounter to private
2,354,763 /  44,718 (saved) - reduced tradePercent to private constant
2,345,444 /   9,319 (saved) - reduced visibility of contractOwner to private
2,335,447 /   9,997 (saved) - removed unused variable tradeMode
2,254,001 /  81,446 (saved) - reduced visibility of payments to private
2,243,696 /  10,306 (saved) - removed unused isReady variable
2,243,696 /       0 (saved) - removed unused variable defaultPayment
2,213,248 /  30,448 (saved) - reduced visibility of paymentHistory to private
2,208,251 /   4,997 (saved) - reduced wasLastOdd & isOddWhitelistUser to bool
2,089,081 / 119,170 (saved) - removed untested events (3)
1,856,447 / 232,634 (saved) - refactored modifier onlyAdminOrOwner
1,755,903 / 100,544 (saved) - refactored modifier checkIfWhitelisted
1,739,915 /  15,988 (saved) - refactored constructor
1,720,011 /  19,904 (saved) - removed unused receive() and fallback()
1,626,046 /  93,965 (saved) - removed unused getPaymentHistory()
1,565,110 /  60,936 (saved) - refactored addHistory()
1,523,573 /  41,537 (saved) - refactored getPayments()
1,430,395 /  93,178 (saved) - refactored transfer()
1,347,852 /  82,543 (saved) - refactored updatePayment()
1,241,769 / 106,083 (saved) - refactored addToWhitelist()
1,172,823 /  68,946 (saved) - refactored whiteTransfer()
1,153,304 /  19,519 (saved) - removed unused contractOwner
1,091,097 /  62,207 (saved) - removed addHistory()
1,054,614 /  36,483 (saved) - refactored ImportantStruct
1,054,206 /     408 (saved) - removed onlyAdmin modifier
  900,849 / 153,357 (saved) - removed checkIfWhitelisted modifier
  885,752 /  15,097 (saved) - simplified conditional statements
  536,547 / 349,205 (saved) - removed unused payments mapping and getPayment(), paymentUpdate(), enum, Payment struct
  505,880 /  30,667 (saved) - small cleanups; Reduction: 81.9%

