// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestElection {
    address public electionAdmin;

    enum PHASE {
        reg,
        voting,
        done
    }

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
        uint age;
        string qualification;
    }

    struct Voter {
        bool hasVoted;
        uint vote;
        bool isRegistered;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => Voter) public registeredVoters;
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
        uint _age,
        string memory _qualification
    ) public onlyAdmin validState(PHASE.reg) {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(
            candidatesCount,
            _name,
            0,
            _party,
            _age,
            _qualification
        );
    }

    function registerVoter(
        address voter
    ) public onlyAdmin validState(PHASE.reg) {
        registeredVoters[voter].isRegistered = true;
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
}
