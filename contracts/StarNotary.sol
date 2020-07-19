pragma solidity >= 0.4.24;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol"

contract StarNotary is ERC721 {
    struct Star {
        string name;
    }

    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;

    //Create Star using Struct

    //Establish name and tokenId as parameters
    function createStar(string memory _name, uint256 _tokenId) public {
        // Star is an struct so we are creating a new Star
        Star memory newStar = Star(_name);
        // Creating in memory the Star -> tokenId mapping
        tokenIdToStarInfo[_tokenId] = newStar;
        // _mint assign the the star with _tokenId to the sender address (ownership)
        _mint(msg.sender, _tokenId);
    }

    //Putting a Star for sale (Adding the star tokenId into the mapping 
    //starsForSale, first verify that the sender is the owner)
    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender, "You can't sell the Star you don't own";
        starsForSale[_tokenId] = price;

    }

    //Function that allows you to convert and addres into a payable address
    function _make_payable(address x) internal pure returns (address payable) {
        return address(uint160(x));
    }

    function buyStar(uint256 _tokenId) public payable {
        require(starsForSale[_tokenId] > 0, "The star is up for sale");
        uint256 starCost = starsForSale[_tokenId];
        address ownerAddress = ownerOf(_tokenId);
        require(msg.value > starCost, "You don't have enough Ether")
        _transferFrom(ownerAddress, msg.sender, _tokenId);
        address payable ownerAddressPayable = _make_payable(ownerAddress);
        ownerAddressPayable.transfer(starCost);
        if(msg.value > starCost) {
            msg.sender.transfer(msg.value - starCost);
        }
    }
};