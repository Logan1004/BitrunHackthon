pragma solidity ^0.4.10;



contract Ownable {

  address owner;

  function Ownable() public {

    owner = msg.sender;

  }



  modifier Owned {

    require(msg.sender == owner);
    _;

  }

}



contract Mortal is Ownable {

  function kill() public Owned {

    selfdestruct(owner);

  }

}



contract Casino is Mortal{
  uint l;
  uint value;
  fixed constant percent=0.05; 
  fixed constant p=0.95;
  uint left=50;
  uint right=60;
  uint rnum1=random();
  uint rnum2=random();
  event Won(bool _status, uint _amount);



  function Casino() payable public {

    require(this.balance > 0);

    value=msg.value;

  }

  

  function() public { //fallback

    revert();

  }



  function bet() payable public {

   uint coinnum=0;
   uint time1=0;
   uint time2=9;
   uint x=left;
   uint y=right;
   uint[] memory dices = generateRandomNumber();
   rnum1=dices[time1];
   rnum2=dices[time2];
    
    while(rnum1>=left&&rnum1<=right){
           time1=time1+1;
           time2=time2-1;
           coinnum=coinnum+1;
          if((rnum2>=0&&rnum2<20)&&(rnum2>=40&&rnum2<80)&&(rnum2>=90&&rnum2<=100)){
            right=right*95/100;
            while(right<=left)
                {left=left*95/100;}
        
            //change();
          }
          else if((rnum2>=20&&rnum2<25)&&(rnum2>=85&&rnum2<90)){
              left=left*95/100;
              //边界判断
              
             // change();
          }
          else{
            
               // change();
          }
          rnum1=dices[time1];
          rnum2=dices[time2];
          if(time1>3){ break;}
    }
        
    if((rnum2>=0&&rnum2<10)&&(rnum2>=30&&rnum2<50)&&(rnum2>=90&&rnum2<=100)){
            right=right*95/100;
            while(right<=left)
                {left=left*95/100;}
        
            
          }
          else if((rnum2>=10&&rnum2<25)&&(rnum2>=50&&rnum2<60)){
              left=left*95/100;
              //边界判断
              
          }
          else{
              
             
          }
    if (coinnum>0) {
      
      msg.sender.transfer(coinnum);
      Won(true,coinnum);

    } else {

        //Won(false, 0);
     
      Won(false,coinnum);
    }
    coinnum=0;

  }
  function generateRandomNumber() private view returns(uint[]) {
    uint[] memory dices = new uint[](10);
    for (uint i = 0; i < 10; i++) {
      dices[i] = uint(keccak256(abi.encodePacked(block.difficulty, now, i))) % 100;
    }
    return dices;
  }
 
  function random() public returns(uint){
      uint winningNumber = uint(keccak256(abi.encodePacked(block.difficulty, now, 0))) % 100 + 1;
      return winningNumber;
  }
  
  

  function checkContractBalance() Owned public view returns(uint) {

      return this.balance;

  }

}