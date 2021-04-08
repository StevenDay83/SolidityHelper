pragma solidity ^0.8.0;

import "./solhelper.sol";

contract TestContract {
    event successBool(bool, string);
    event printString(string);
    event printInt(uint256);
    
    constructor(){}
    
    function testLibrary(uint256 _testNumber, string memory _testString) public returns (bool) {
        bool testSuccess = false;
        
        string memory convertedNumberToString = SolHelper.uint256ToString(_testNumber);
        uint256 convertedStringToNumber = SolHelper.stringToUint256(convertedNumberToString);
        
        emit printString(convertedNumberToString);
        emit printInt(convertedStringToNumber);
        
        if (convertedStringToNumber == _testNumber) {
            emit successBool(true, "Conversion functions successful.");
            
            string memory _testUpper = SolHelper.toUpper(_testString);
            string memory _testLower = SolHelper.toLower(_testString);
            
            emit printString(_testUpper);
            emit printString(_testLower);
            
            if (SolHelper.compareString(_testUpper, _testUpper)){
                emit successBool(true, "String comparison to self successful.");
                
                if (!SolHelper.compareString(_testUpper, _testLower)){
                    emit successBool(true, "String comparison upper and lower case successful.");
                    
                    if (!SolHelper.isEmptyString(_testString)){
                        emit successBool(true, "String comparison to empty string successful.");
                        
                        testSuccess = true;
                    } else {
                        emit successBool(false, "String comparison to empty string failed.");
                    }
                } else {
                    emit successBool(false, "String comparison upper and lower case failed.");
                }
            } else {
                emit successBool(false, "String comparison to self failed.");
            }
        } else {
            emit successBool(false, "Conversion functions failed.");
        }
        
        return testSuccess;
    }
}