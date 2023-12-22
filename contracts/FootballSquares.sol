// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// import "@openzeppelin/contracts/access/Ownable.sol";

// contract FootballSquares is Ownable {
contract FootballSquares {

    // constructor(address _owner) Ownable(_owner) {
    // }

    event SquaresClaimed(address indexed _from, uint _value);
    event SquarePayout(address indexed _to, uint _value);

    event ContractLiquidated(address indexed _payee, uint _value);
    event Log(string message, uint _value);

    mapping(string => mapping(address => string)) public playerClaimedSquaresByGame;

    function claimSquares(
        string memory _gameId,
        address _playerAddress,
        string memory _hash
    ) public payable {
        require(msg.value > 0, "Must stake a positive amount of ether");

        playerClaimedSquaresByGame[_gameId][_playerAddress] = _hash;

        emit SquaresClaimed(msg.sender, msg.value);
    }

    function payoutSquare(
        address _playerAddress,
        uint256 _value
    // ) public onlyOwner {
    ) public {
        payable(_playerAddress).transfer(_value);

        emit SquarePayout(_playerAddress, _value);
    }

    // function withdraw() public onlyOwner {
    function withdraw() public {
        uint256 balance = address(this).balance;
        // payable(owner()).transfer(balance);
        emit ContractLiquidated(msg.sender, balance);
    }

    // function getBalance() public view onlyOwner returns (uint256) {
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}