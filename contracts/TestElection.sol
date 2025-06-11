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
        string email;
        string voterID;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => Voter) public registeredVoters;
    address[] public voterAddresses;
    uint public candidatesCount;

    mapping(string => bool) private usedEmails;
    mapping(string => bool) private usedVoterIDs;

    modifier onlyAdmin() {
        require(msg.sender == electionAdmin, "Only admin can perform this action");
        _;
    }

    modifier validState(PHASE x) {
        require(currentElectionStage == x, "Invalid phase for this action");
        _;
    }

    event VoterRegistered(address voter, string name);
    event CandidateAdded(uint candidateId, string name);
    event VoteCast(address voter, uint candidateId);

    function changeState(PHASE x) public onlyAdmin {
        require(x > currentElectionStage, "Can only move to a later phase");
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
        emit CandidateAdded(candidatesCount, _name);
    }

    function registerVoter(
        address voter,
        string memory _localGovernment,
        string memory _name,
        string memory _email,
        string memory _voterID
    ) public onlyAdmin validState(PHASE.reg) {
        require(!registeredVoters[voter].isRegistered, "Voter already registered");
        require(!usedEmails[_email], "Email already used");
        require(!usedVoterIDs[_voterID], "Voter ID already used");

        registeredVoters[voter] = Voter({
            hasVoted: false,
            vote: 0,
            isRegistered: true,
            name: _name,
            localGovernment: _localGovernment,
            email: _email,
            voterID: _voterID
        });

        voterAddresses.push(voter);
        usedEmails[_email] = true;
        usedVoterIDs[_voterID] = true;

        emit VoterRegistered(voter, _name);
    }

    function castVote(uint _candidateId) public validState(PHASE.voting) {
        require(registeredVoters[msg.sender].isRegistered, "Not registered");
        require(!registeredVoters[msg.sender].hasVoted, "Already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        candidates[_candidateId].voteCount++;
        registeredVoters[msg.sender].hasVoted = true;
        registeredVoters[msg.sender].vote = _candidateId;

        emit VoteCast(msg.sender, _candidateId);
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

    function getAllVoterAddresses() public view returns (address[] memory) {
        return voterAddresses;
    }

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
            string memory localGovernment,
            string memory email,
            string memory voterID
        )
    {
        Voter memory v = registeredVoters[voter];
        return (
            v.hasVoted,
            v.vote,
            v.isRegistered,
            v.name,
            v.localGovernment,
            v.email,
            v.voterID
        );
    }
}