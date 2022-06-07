// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract Voting {
    
    struct Voter {
        uint amount;
        uint maturity;
        bool paid;
    }

    struct Vote {
        uint amount;
        uint maturity;
        bool paid;
    }

    struct Campaign {
        string name;
        //mapping(string => Candidate) candidates;
        Candidate[] candidates; 
        //startDateTime;
        //endDateTime;
    }

    struct Candidate {
        string name;
        string sign;
        uint votes;
    }

   // Campaign[] public campaigns; 

    mapping(string => Campaign) public campaigns;
   
   
    //Candidate[] public candidates;

    uint numberOfCampaigns;

    string[] public compaignNames;

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function addCampaign(string memory campaignName) public {
        require(msg.sender == admin, 'Only admin can start a campaign');
        //require(campaigns[campaignName].name == 0 , 'Campaign already exists');
        //Candidate memory candidate = Candidate('name-1', 'sign-1', 0);
        //Candidate[1] memory candidates = [candidate];
        //campaigns[campaignName] = Campaign(campaignName, candidates);
        // campaigns[campaignName] = Campaign({
        //     name: '1122'            
        // });
        Campaign storage comp = campaigns[campaignName];
        comp.name = campaignName;
        //comp.candidates['cand'] =  Candidate('name-1', 'sign-1', 0);
        //comp.candidates.push(Candidate('name-1', 'sign-1', 0));
        numberOfCampaigns++;
        compaignNames.push(campaignName);
        //     Campaign({
        //     name: '1122'            
        // });
        // campaigns[0] = Campaign({
        //     name: '1122'            
        // });


        //campaigns[campaignName].candidates.push(Candidate('name-1', 'sign-1', 0));
    }

    function addCandidate( string memory campaignName, string memory candidateName, string memory candidateSign) public {
        require(msg.sender == admin, 'Only admin can add a candidate');
        campaigns[campaignName].candidates.push(Candidate(candidateName, candidateSign, 0));
    }

    function voteForCandidate( string memory campaignName, string memory candidateName) public {
        for(uint i = 0; i < campaigns[campaignName].candidates.length; i++) {
            Candidate memory candidate = campaigns[campaignName].candidates[i];
            if (keccak256(bytes(candidate.name)) == keccak256(bytes(candidateName))) {
                campaigns[campaignName].candidates[i].votes++;
            }
        }
        
    }

    function getCandidateVotes( string memory campaignName, string memory candidateName) public view returns (uint votes) {
        for(uint i = 0; i < campaigns[campaignName].candidates.length; i++) {
            Candidate memory candidate = campaigns[campaignName].candidates[i];
            if (keccak256(bytes(candidate.name)) == keccak256(bytes(candidateName))) {
                return candidate.votes;
            }
        }
        return 0;
    }

    // function getWinningCandidate( string memory campaignName) public view returns (string votes) {
    //     string memory winning candidate
    //     for(uint i = 0; i < campaigns[campaignName].candidates.length; i++) {
    //         Candidate memory candidate = campaigns[campaignName].candidates[i];
    //         if (keccak256(bytes(candidate.name)) == keccak256(bytes(candidateName))) {
    //             return candidate.votes;
    //         }
    //     }
    //     return 0;
    // }


    
    
    // update this
    function getcompaignInfo(string memory campaignName)public view returns(Campaign memory campaign){
        return campaigns[campaignName];
    }

    function getAllCompainNames() public view returns (string[] memory campaignNames) {
        string[] memory memoryArray = new string[](numberOfCampaigns);
        for(uint i = 0; i < numberOfCampaigns; i++) {
            memoryArray[i] = campaigns[compaignNames[i]].name;
        }
        return memoryArray;
    }


     function getNumResult() public view returns (uint res) {
         return 123;
     }
    // function StartCampaign(Campaign memory campaign) public {
    //     require(msg.sender == admin, 'Only admin can start a campaign');
    //     //require(campaigns[campaign] != 0, 'Campaign already exists');
    // }

    // function getAllCampaigns()public returns(address[] memory){
    //     return campaigns;
    // }

/*
    address public kid;
    uint public maturity;
    constructor(address _kid, uint timeToMaturity) payable {
        kid = _kid;
        maturity = block.timestamp +  timeToMaturity;
    }

    function withdraw() external {
        require(block.timestamp >= maturity, 'Grow up');
        require(msg.sender == kid, 'Only kid can withdraw');
        payable(msg.sender).transfer(address(this).balance); 
    }
    */
}