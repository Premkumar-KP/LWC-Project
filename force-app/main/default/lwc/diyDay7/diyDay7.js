import { LightningElement } from 'lwc';

export default class DiyDay7 extends LightningElement {

    checkTheCharacter(){
        let x='abca';
        if(x.indexOf('a')>=0){
            console.log('Character is avlaible in the index of  '+x.indexOf('a'))
        } else{
            console.log('Character not available in the string');
        }
    }

    checkXIsOneOrMore(){
      const x = 'xabcx';
      let count = 0;
      for (let i = 0; i < x.length; i++) {
        if (x[i] === 'x') {
          count++;
        }
      }
      if (count > 0) {
        console.log(`The string contains ${count} characters of 'x'`);
      } else {
        console.log('The string does not contain any "x" characters');
      }
    }

    checkTheValuesIsDecimalOrInteger(){
      let x = "10.25";
      if (x.includes(".")) {
          console.log(`${x} is decimal`);
      } else {
          console.log(`${x} is an integer`);
      }
    }

    checktheNumberisOddOrEven(){
      let number = 7;

        switch (number % 2) {
          case 0:
            console.log(`${number} is even`);
            break;
          case 1:
            console.log(`${number} is odd`);
            break;
        }
    }

    doCalculation(){
      let x = 10;
      let y = 20;
      let option = 1;

      switch (option) {
        case 1:
          console.log(`Sum of ${x} and ${y} is ${x + y}`);
          break;
        case 2:
          console.log(`Subtraction of ${x} and ${y} is ${x - y}`);
          break;
        case 3:
          console.log(`Multiplication of ${x} and ${y} is ${x * y}`);
          break;
        case 4:
          console.log(`Division of ${x} and ${y} is ${x / y}`);
          break;
        default:
          console.log('Invalid option');
      }

    }

    handleClick(){
        this.checkTheCharacter();
      }
    handleClick2(){
        this.checkXIsOneOrMore();
      }
      handleClick3(){
        this.checkTheValuesIsDecimalOrInteger();
      }
      handleClick4(){
        this.checktheNumberisOddOrEven();
      }
      handleClick5(){
       this.doCalculation();
      }
}