// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//create user structure
contract UserInfo {

    struct PersonalInfo {
        string name;
        uint age;
        string email;
    }

    mapping(address => PersonalInfo) private users; // create address

    event UserInfoUpdated(address indexed user, string name, uint age, string email); //notify all users on user update

    function setUserInfo(string memory _name, uint _age, string memory _email) public {
        users[msg.sender] = PersonalInfo(_name, _age, _email); //take user input then store into address
        emit UserInfoUpdated(msg.sender, _name, _age, _email); //call broadcaster to notify all users
    }

    //NB. 'view' means function can only read data
    function getUserInfo() public view returns (string memory, uint, string memory){
        PersonalInfo memory info = users[msg.sender];
        return (info.name, info.age, info.email);
    }
}