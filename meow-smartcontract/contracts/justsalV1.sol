// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721RoyaltyUpgradeable.sol";

contract JustSalV1 is ERC721RoyaltyUpgradeable, OwnableUpgradeable {
    uint256 public tokenCounter;

    string baseUri;
    string baseExtension;

    uint256 public revealTime;
    uint256 public maxMintCount;

    mapping(uint256 => uint256) public revealTimestamp;

    event Minted(address Owner, uint256[] TokenIds);

    function initialize() public initializer {
        __ERC721_init("JustSal", "SAL");
        __Ownable_init();
        __ERC721Royalty_init();

        tokenCounter = 0;
        _setDefaultRoyalty(_msgSender(), 50);

        baseUri = "https://nftstorage.link/ipfs/bafybeieelfur3354bogimdhoylwo56vdlfil2m6motffpfw4bwx3g6w6t4/";
        baseExtension = ".json";

        maxMintCount = 100000;
        revealTime = 3600;
    }

    function updateDefaultURI(
        string memory _base,
        string memory _extension
    ) external virtual {
        baseUri = _base;
        baseExtension = _extension;
    }

    function updateData(
        uint256 _max_count,
        uint256 _reveal_time
    ) external virtual {
        maxMintCount = _max_count;
        revealTime = _reveal_time;
    }

    function mint(uint256 _mintAmount) external {
        require(
            (_mintAmount + tokenCounter) <= maxMintCount,
            "JustSalV1: Exceeds limit"
        );

        uint256[] memory ids = new uint256[](_mintAmount);
        for (uint256 i; i < _mintAmount; i++) {
            tokenCounter += 1;
            _mint(_msgSender(), tokenCounter);
            revealTimestamp[tokenCounter] = block.timestamp;
        }

        emit Minted(_msgSender(), ids);
    }

    function setDefaultRoyalty(
        address receiver,
        uint96 feeNumerator
    ) external virtual onlyOwner {
        _setDefaultRoyalty(receiver, feeNumerator);
    }

    function setTokenRoyalty(
        uint256 tokenId,
        address receiver,
        uint96 feeNumerator
    ) external virtual onlyOwner {
        _setTokenRoyalty(tokenId, receiver, feeNumerator);
    }

    function tokenURI(
        uint256 _tokenId
    ) public view virtual override returns (string memory) {
        require(
            _exists(_tokenId),
            "JustSalV1: URI query for nonexistent token"
        );
        if (revealTimestamp[_tokenId] + revealTime > block.timestamp) {
            return
                "https://ipfs.io/ipns/k51qzi5uqu5dga80nmz03om61vj0eujzbbfgi47rmmcqjuvgph7wuask8lvdk5/meowunreveal.json";
        }
        return
            string(
                abi.encodePacked(
                    baseUri,
                    StringsUpgradeable.toString(_tokenId),
                    baseExtension
                )
            );
    }
}

