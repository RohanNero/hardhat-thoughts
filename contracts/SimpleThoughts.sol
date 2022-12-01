//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

error Thoughts__InvalidAddress(address addr);

contract Thoughts {
    address public owner; // only one address is allowed to create thoughts at a time

    Thought[] public thoughtArray; // instead of using an array, should I use a mapping? wouldn't be able to iterate through..

    struct Thought {
        string thought; // may be better to use uri depending on size
        uint24 thoughtId; // id number used to track specific thoughts
    }

    event ThoughtShared(uint24 thoughtId, address thinker);
    event OwnerChanged(address oldOwner, address newOwner);

    modifier onlyOwner(address addr) {
        if (msg.sender != owner) {
            revert Thoughts__InvalidAddress(addr);
        }
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createThought(
        string memory thought
    ) public onlyOwner(msg.sender) returns (uint24) {
        Thought memory memThought = Thought(
            thought,
            uint24(thoughtArray.length)
        );
        thoughtArray.push(memThought);
        emit ThoughtShared(memThought.thoughtId, msg.sender);
    }

    /**@dev sets owner equal to msg.sender */
    function changeOwner(address newOwner) public onlyOwner(msg.sender) {
        if (msg.sender != owner || newOwner == owner) {
            revert Thoughts__InvalidAddress(msg.sender);
        }
        address oldOwner = owner;
        owner = msg.sender;
        emit OwnerChanged(oldOwner, owner);
    }
}
