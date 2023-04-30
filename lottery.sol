pragma solidity ^0.8.19;


contract Lottery {
uint public allPeopleCount = 0;
// uint256 totalAmount;
struct  Partipicant {
  address payable id;
}
event getRandom(string error, uint _value);



// mapping (address => Partipicant[])  public Partipicants;
Partipicant[] Partipicants;
function buyTicket( ) public payable  {
  require(msg.value == 1 ether,"ticket price is 1 ethereum");
  require(isMemberExist(msg.sender) == false, "you are already partipicant");
//   require(userInfo[msg.sender].userAddress != address(0));
     Partipicants.push(Partipicant(payable(msg.sender)));
     allPeopleCount++;
     if(allPeopleCount >= 5) {
         PayoutWinning();
     }
}

function random(uint number) public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,  
        msg.sender))) % number;
}


 function isMemberExist(address userAddress) 
  public 
  view 
  returns(bool exists) 
{
      for (uint i; i < Partipicants.length; i++) {
        if (Partipicants[i].id == userAddress) {
            // corresponding item found - update quantity and early return
            return true;
        }
    }

}


function getBalance() public view returns (uint) {
  return address(this).balance;
}


function PayoutWinning() public payable {
  emit getRandom("this is random number from all address", random(Partipicants.length));

 payable (Partipicants[random(Partipicants.length)].id).transfer(getBalance());

} 


}