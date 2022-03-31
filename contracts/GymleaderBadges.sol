//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract GymleaderBadges is ERC1155, AccessControl{
    uint256 public constant AQUA = 1;
    uint256 public constant BEAST = 2;
    uint256 public constant BIRD = 3;
    uint256 public constant BUG = 4;
    uint256 public constant DAWN = 5;
    uint256 public constant DUSK = 6;
    uint256 public constant MECH = 7;
    uint256 public constant PLANT = 8;
    uint256 public constant REPTILE = 9;

    bytes32 public constant AQUA_GYM_LEADER = keccak256("AQUA_GYM_LEADER");
    bytes32 public constant BEAST_GYM_LEADER = keccak256("BEAST_GYM_LEADER");
    bytes32 public constant BIRD_GYM_LEADER = keccak256("BIRD_GYM_LEADER");
    bytes32 public constant BUG_GYM_LEADER = keccak256("BUG_GYM_LEADER");
    bytes32 public constant DAWN_GYM_LEADER = keccak256("DAWN_GYM_LEADER");
    bytes32 public constant DUSK_GYM_LEADER = keccak256("DUSK_GYM_LEADER");
    bytes32 public constant MECH_GYM_LEADER = keccak256("MECH_GYM_LEADER");
    bytes32 public constant PLANT_GYM_LEADER = keccak256("PLANT_GYM_LEADER");
    bytes32 public constant REPTILE_GYM_LEADER = keccak256("REPTILE_GYM_LEADER");
    bytes32 public constant TRANSFER = keccak256("TRANSFER");
    bytes32 public constant ADMIN = keccak256("ADMIN");

    string private _baseMetadataUri;
    string public name;
    string public symbol;

    bool private _transferEnabled = false;

    constructor(string memory _name, string memory _symbol) ERC1155(""){
        _grantRole(AQUA_GYM_LEADER, msg.sender);
        _grantRole(BEAST_GYM_LEADER, msg.sender);
        _grantRole(BIRD_GYM_LEADER, msg.sender);
        _grantRole(BUG_GYM_LEADER, msg.sender);
        _grantRole(DAWN_GYM_LEADER, msg.sender);
        _grantRole(DUSK_GYM_LEADER, msg.sender);
        _grantRole(MECH_GYM_LEADER, msg.sender);
        _grantRole(PLANT_GYM_LEADER, msg.sender);
        _grantRole(REPTILE_GYM_LEADER, msg.sender);
        _grantRole(ADMIN, msg.sender);
        setBaseMetadataURI("ipfs://QmYeU7iRaxgKhPFqipxjQV6Gvnadqz3uFWLurK1jCLjayv/");

        name  = _name;
        symbol = _symbol;
    }

    function uri(uint256 _id) public view virtual override returns (string memory) {
        return string(abi.encodePacked(
            _baseMetadataUri,
            Strings.toString(_id)
        ));
    }

    function setBaseMetadataURI (
        string memory _newBaseMetadataURI
    ) public onlyRole(ADMIN) {
        _baseMetadataUri = _newBaseMetadataURI;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes memory data) public virtual override {
        require(_transferEnabled);
        super.safeTransferFrom(from, to, id, amount, data);
    }

    function safeBatchTransferFrom(address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public virtual override {
        require(_transferEnabled);
        _safeBatchTransferFrom(from, to, ids, amounts, data);
    }

//    Cannot be reverted - once transfer is enabled it cannot be disabled again
    function enableTransfer() public onlyRole(ADMIN){
        _transferEnabled = true;
    }

    function mintAquaBadge(address _to) public onlyRole(AQUA_GYM_LEADER){
        _mint(_to, AQUA, 1, "");
    }

    function mintBeastBadge(address _to) public onlyRole(BEAST_GYM_LEADER){
        _mint(_to, BEAST, 1, "");
    }

    function mintBirdBadge(address _to) public  onlyRole(BIRD_GYM_LEADER){
        _mint(_to, BIRD, 1, "");
    }

    function mintBugBadge(address _to) public  onlyRole(BUG_GYM_LEADER){
        _mint(_to, BUG, 1, "");
    }

    function mintDawnBadge(address _to) public  onlyRole(DAWN_GYM_LEADER){
        _mint(_to, DAWN, 1, "");
    }

    function mintDuskBadge(address _to) public  onlyRole(DUSK_GYM_LEADER){
        _mint(_to, DUSK, 1, "");
    }

    function mintMechBadge(address _to) public  onlyRole(MECH_GYM_LEADER){
        _mint(_to, MECH, 1, "");
    }

    function mintPlantBadge(address _to) public  onlyRole(PLANT_GYM_LEADER){
        _mint(_to, PLANT, 1, "");
    }
    function mintReptileBadge(address _to) public  onlyRole(REPTILE_GYM_LEADER){
        _mint(_to, REPTILE, 1, "");
    }

    function mint(address _to, uint256 _id) public  onlyRole(ADMIN){
        _mint(_to, _id, 1, "");
    }


    function grantRole(bytes32 _role, address _account) public virtual override onlyRole(ADMIN) {
        _grantRole(_role, _account);
    }





}

