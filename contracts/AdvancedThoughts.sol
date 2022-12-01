//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

error Thoughts__InvalidAddress(address addr);

contract Thoughts {
    uint32 public counter;

    // so you can add addresses you want to be allowed to share thoughts
    //mapping(address => bool) public addressMapping;
    address public owner; // changed to only allow one address at a time to create thoughts

    // instead of using an array, could I just use events to display thoughts? no bc I want to be able to view previous thoughts
    Thought[] public thoughtArray;
    PersistentThought[] public persistentThoughtArray;

    struct Thought {
        string thought; // may be better to use uri depending on size
        uint24 thoughtId; // id number used to track specific thoughts
        //uint40 timestamp; // timestamp of when thought was created on-chain (is this needed?)
    }

    struct PersistentThought {
        string[3] uriArray; // up to three copies of the uri/url incase they no longer work (for example if ipfs were to die)
        uint24 thoughtId; // id number used to track specific thoughts
        uint40 timestamp; // timestamp of when thought was created on-chain
    }

    // modifier onlyAllowed(address addr) {
    //     if (addressMapping[addr] == false) {
    //         revert Thoughts__InvalidAddress(addr);
    //     }
    //     _;
    // }

    constructor() {
        owner = msg.sender;
    }

    function createThought(Thought memory thought) public returns (uint24) {
        if (msg.sender != owner) {
            revert Thoughts__InvalidAddress(msg.sender);
        }
    }

    function createPersistentThought(
        string memory thought
    ) public returns (uint24) {
        if (msg.sender != owner) {
            revert Thoughts__InvalidAddress(msg.sender);
        }
    }

    //function enableAddress(address addr, uint test) public onlyAllowed(addr) {}

    function changeOwner(address newOwner) public {
        if (msg.sender != owner) {
            revert Thoughts__InvalidAddress(msg.sender);
        }
    }

    ///@notice want users to be able to favorite certain thoughts to easily be able to find them again, show off, etc.
    function addToFavorites(uint24 thoughtId) public {
        if (msg.sender != owner) {
            revert Thoughts__InvalidAddress(msg.sender);
        }
    }
}
