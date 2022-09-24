pragma solidity 0.4.23;

contract Vote {

    // structure
    struct condidator {
        string name;
        uint upVote;
    }

    // variable
    bool live;
    condidator[] public condidatorList;
    address owner;


    // mapping
    mapping(address => bool) Voted;

    // event
    event AddCandidator(string name);
    event UpVote(string condidator, uint upVote);
    event FinishVote(bool live);
    event Voting(address owner);

    // modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // constructor
    constructor() public {
        owner = msg.sender;
        live = true;

        emit Voting(owner);
    }

    // candidator
    function addCandidator(string _name) public onlyOwner {
        require(condidatorList.length < 5);
        condidatorList.push(condidator(_name, 0));
        
        // emit event
        emit AddCandidator(_name);
    }

    function upVote(uint _indexOfCondidator) public {
        require(_indexOfCondidator < condidatorList.length);
        require(Voted[msg.sender] == false);
        condidatorList[_indexOfCondidator].upVote++;

        Voted[msg.sender] = true;
        emit UpVote(condidatorList[_indexOfCondidator].name, condidatorList[_indexOfCondidator].upVote);
    }
    // voting
    
    // finish vote
    function finishVote() public onlyOwner {
        live = false;
        emit FinishVote(live);
    }
}




