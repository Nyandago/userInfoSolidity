// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//create user structure
contract UserInfo {

    struct PersonalInfo {
        string name;
        uint age;
        string email;
    }

    address private owner;

    mapping(address => mapping(uint => PersonalInfo)) private users; // create address

    modifier onlyOwner(){
        require(msg.sender == owner , "Only the owner is allowed to perform this transaction");
        _;
    }

    event UserInfoUpdated(address indexed user, uint userID, string name, uint age, string email); //notify all users on user update

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(){
        owner = msg.sender;
    }

    function setUserInfo(uint _userID, string memory _name, uint _age, string memory _email) public onlyOwner {
        users[msg.sender][_userID] = PersonalInfo(_name, _age, _email); //take user input then store into address
        emit UserInfoUpdated(msg.sender, _userID, _name, _age, _email); //call broadcaster to notify all users
    }

    //NB. 'view' means function can only read data
    function getUserInfo(address userAddress, uint _userID) public view returns (string memory, uint, string memory){
        PersonalInfo memory info = users[userAddress][_userID];
        return (info.name, info.age, info.email);
    }

    //tells if address has user info in it
    function hasUserInfo(address userAddress, uint _userID) public view returns (bool){
        return bytes(users[userAddress][_userID].name).length > 0;
    }

    function transferOwnership(address _newOwner) public onlyOwner{
        require(_newOwner != owner, "New Owner can not be the same as current owner");
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }

    function isOwner(address _enteredAddress) public view returns (bool){
        return _enteredAddress == owner;
    }
    
}