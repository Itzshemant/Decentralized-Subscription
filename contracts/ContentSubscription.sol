// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ContentSubscription {
    address public owner;
    uint256 public subscriptionFee;
    mapping(address => uint256) public subscribers;

    event Subscribed(address indexed user, uint256 expiry);
    event Unsubscribed(address indexed user);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this.");
        _;
    }

    constructor(uint256 _fee) {
        owner = msg.sender;
        subscriptionFee = _fee;
    }

    function subscribe() external payable {
        require(msg.value == subscriptionFee, "Incorrect fee");
        subscribers[msg.sender] = block.timestamp + 30 days;
        emit Subscribed(msg.sender, subscribers[msg.sender]);
    }

    function unsubscribe() external {
        require(subscribers[msg.sender] > 0, "Not subscribed");
        delete subscribers[msg.sender];
        emit Unsubscribed(msg.sender);
    }

    function isSubscribed(address _user) external view returns (bool) {
        return subscribers[_user] > block.timestamp;
    }

    function changeFee(uint256 _newFee) external onlyOwner {
        subscriptionFee = _newFee;
    }
}
