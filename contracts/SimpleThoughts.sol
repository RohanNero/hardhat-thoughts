//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

error SimpleThoughts__InvalidAddress(address addr);

contract SimpleThoughts {
    address public owner; // only one address is allowed to create thoughts at a time

    Thought[] public thoughtArray; // instead of using an array, should I use a mapping? wouldn't be able to iterate through..

    struct Thought {
        string thought; // may be better to use uri depending on size
        uint24 thoughtId; // id number used to track specific thoughts
    }

    event ThoughtShared(uint24 thoughtId, address thinker);
    event OwnerChanged(address oldOwner, address newOwner);

    // deciding whether or not to revert if changeOwner() is called with current owner address, if I do then I won't need this modifier
    // modifier onlyOwner(address addr) {
    //     if (msg.sender != owner) {
    //         revert SimpleThoughts__InvalidAddress(addr);
    //     }
    //     _;
    // }

    constructor() {
        owner = msg.sender;
    }

    function shareThought(string memory thought) public {
        if (msg.sender != owner) {
            revert SimpleThoughts__InvalidAddress(msg.sender);
        }
        Thought memory memThought = Thought(
            thought,
            uint24(thoughtArray.length)
        );
        thoughtArray.push(memThought);
        emit ThoughtShared(memThought.thoughtId, msg.sender);
    }

    /**@dev sets owner equal to msg.sender */
    function changeOwner(address newOwner) public {
        if (msg.sender != owner || newOwner == owner) {
            revert SimpleThoughts__InvalidAddress(msg.sender);
        }
        address oldOwner = owner;
        owner = newOwner;
        emit OwnerChanged(oldOwner, owner);
    }
}
