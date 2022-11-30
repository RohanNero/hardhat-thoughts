//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Thoughts {
    // left off right here, want a thought to have tags to be sortable. Also a thought should have one (or more URIs?) containing the info
    struct Tag {
        string name; // tag name
        string desc; // may be a uri if the description is long
    }

    struct Thought {
        string[3] uriArray; // up to three copies of the uri/url incase they no longer work (for example if ipfs were to die)
        Tag tag;    // a tag struct used to sort thoughts
        uint24 thoughtId; // id number used to track specific thoughts
    }

    Tag[] public tagArray;
}
