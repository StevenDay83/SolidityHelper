pragma solidity >=0.8.0;

library SolHelper {
   
   bytes32 constant emptyString = 0x569e75fc77c1a856f6daaf9e69d8a9566ca34aa47f9133711ce065a571af0cfd;
   
   function uint256ToString(uint256 _number) public pure returns (string memory) {
        string memory finalString;
        uint256 _thisNumber = _number;
        bool isDone = false;
        
        while(!isDone){
            uint256 _getDigit = _thisNumber % 10;
            finalString = string(abi.encodePacked(digitToString(uint8(_getDigit)), finalString));
            _thisNumber = (_thisNumber - _getDigit) / 10;
            
            if (_thisNumber == 0){
                isDone = true;
            }
        }
        return finalString;
   }
   
   function digitToString(uint8 _thisDigit) internal pure returns (string memory){
       return string(abi.encodePacked(bytes1(uint8(_thisDigit + 48))));
   }
   
   function stringToUint256(string memory _string) public pure returns (uint256) {
       bytes memory bytesString = bytes(_string);
       uint256 finalNum = 0;
       
       for (uint256 i = 0; i < bytesString.length; i++) {
           uint256 _powerOf10 = 10 ** ((bytesString.length - 1) - i);
          finalNum = finalNum + (_powerOf10 * byteToDec(bytesString[i]));
       }
       
       return finalNum;
   }
   
   function byteToDec(bytes1 _thisByte) internal pure returns (uint8) {
       uint8 _thisDigit = 0;
       
       if (uint8(_thisByte) >= 48 && uint8(_thisByte) <= 57) {
           _thisDigit = uint8(_thisByte) - 48;
       }
       
       return _thisDigit;
   }
   
   function toLower(string memory _thisString) public pure returns (string memory) {
       bytes memory bytesString = bytes(_thisString);
       
       for (uint256 i = 0; i < bytesString.length; i++){
          uint8 _decVal = uint8(bytesString[i]);
           
           if (_decVal >= 65 && _decVal <= 90){
               bytesString[i] = bytes1(uint8(_decVal + 32));
           }
       }
       
       return string(abi.encodePacked(bytesString));
   }
   
   function toUpper(string memory _thisString) public pure returns (string memory) {
        bytes memory bytesString = bytes(_thisString);
       
       for (uint256 i = 0; i < bytesString.length; i++){
          uint8 _decVal = uint8(bytesString[i]);
           
           if (_decVal >= 97 && _decVal <= 122){
               bytesString[i] = bytes1(uint8(_decVal - 32));
           }
       }
       
       return string(abi.encodePacked(bytesString));
   }
   
   function isEmptyString(string memory _thisString) public pure returns (bool) {
       return keccak256(abi.encode(_thisString)) == emptyString;
   }
   
   function compareString(string memory _s1, string memory _s2) public pure returns (bool) {
       return keccak256(abi.encode(_s1)) == keccak256(abi.encode(_s2));
   }
}