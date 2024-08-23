// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestElection {
    enum PHASE {
        reg,
        voting,
        done
    }

    address public electionAdmin;
    PHASE public currentElectionStage;

    constructor() {
        electionAdmin = msg.sender;
        currentElectionStage = PHASE.reg;
    }

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        string party;
        string dob;
        string qualification;
        string localGovernment;
    }

    struct Voter {
        bool hasVoted;
        uint vote;
        bool isRegistered;
        string name;
        string localGovernment;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => Voter) public registeredVoters;
    address[] public voterAddresses; // New array to store voter addresses
    uint public candidatesCount;

    modifier onlyAdmin() {
        require(msg.sender == electionAdmin);
        _;
    }

    modifier validState(PHASE x) {
        require(currentElectionStage == x);
        _;
    }

    function changeState(PHASE x) public onlyAdmin {
        require(x > currentElectionStage);
        currentElectionStage = x;
    }

    function addCandidate(
        string memory _name,
        string memory _party,
        string memory _dob,
        string memory _qualification,
        string memory _localGovernment
    ) public onlyAdmin validState(PHASE.reg) {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(
            candidatesCount,
            _name,
            0,
            _party,
            _dob,
            _qualification,
            _localGovernment
        );
    }

    function registerVoter(
        address voter,
        string memory _localGovernment,
        string memory _name
    ) public onlyAdmin validState(PHASE.reg) {
        registeredVoters[voter] = Voter({
            hasVoted: false,
            vote: 0,
            isRegistered: true,
            name: _name,
            localGovernment: _localGovernment
        });
        voterAddresses.push(voter); // Store the voter's address
    }

    function castVote(uint _candidateId) public validState(PHASE.voting) {
        require(registeredVoters[msg.sender].isRegistered);
        require(!registeredVoters[msg.sender].hasVoted);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        candidates[_candidateId].voteCount++;
        registeredVoters[msg.sender].hasVoted = true;
        registeredVoters[msg.sender].vote = _candidateId;
    }

    function getWinner()
        public
        view
        validState(PHASE.done)
        returns (
            string memory winnerName,
            uint winnerVoteCount,
            string memory winnerParty
        )
    {
        require(candidatesCount > 0, "No candidates available");

        uint winningVoteCount = 0;
        uint winningCandidateId = 0;

        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateId = i;
            }
        }

        Candidate memory winner = candidates[winningCandidateId];
        return (winner.name, winner.voteCount, winner.party);
    }

    // New function to get all voter addresses
    function getAllVoterAddresses() public view returns (address[] memory) {
        return voterAddresses;
    }

    // New function to get voter details
    function getVoterDetails(
        address voter
    )
        public
        view
        returns (
            bool hasVoted,
            uint vote,
            bool isRegistered,
            string memory name,
            string memory localGovernment
        )
    {
        Voter memory v = registeredVoters[voter];
        return (v.hasVoted, v.vote, v.isRegistered, v.name, v.localGovernment);
    }
}
