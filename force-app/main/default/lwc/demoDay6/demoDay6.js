import { LightningElement } from 'lwc';

export default class DemoDay6 extends LightningElement {
    
     findGreaterBetweenTwoNumber(){
      let x=10;
      let y=20;
      if (x > y) {
        alert(`${x} is greater than ${y}`);
      } else if (y > x) {
        alert(`${y} is greater than ${x}`);
      } else {
        alert("Both numbers are equal");
      }
    }

    findGreaterBetweenThreeNumber(){
      let x=10;
      let y=20;
      let z=30;
      if(x>y && x>z){
        console.log(`${x} is greater`);
      } else if(y>z){
        console.log(`${y} is greater`);
      } else{
        console.log(`${z} is greater`);
      } 
    }

    findTheValueIsNumberOrNot(){
      let x=20;
        if (!isNaN(x)) {
            console.log('Value is a number');
        } else {
            console.log('Value is not a number');
        }
    }

    handleClick(){
      this.findGreaterBetweenTwoNumber();
    }

    handleClick2(){
      this.findGreaterBetweenThreeNumber();
    }

    handleClick3(){
      this.findTheValueIsNumberOrNot();
    }
}