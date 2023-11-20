import { LightningElement } from 'lwc';

export default class DiyDay11 extends LightningElement {
    addValuesToTheArray(){
        let x=[10,5,3,20,50,9]
        let newArray= x.map((numbers)=>{
            //let newArray = [...x].map((a) => {
            if(numbers %2 ===0){
                return numbers+10;
            } else {
                return numbers+5;     
            }
        })
        newArray.forEach(values=>console.log(values))
    }

    checkTheValuesPresentOrNotInTheArray(){
        let containsElement = function(array, value) {
            return array.includes(value);
          };
          let x = [10, 20, 5, 3, 200];
          if(containsElement(x, 45)){
            console.log('Values Present In The Array')
          } else {
            console.log('Values Not Present In The Array')
            }
    }

    arithrmaticOperation(){
        const sum=(x,y)=>{return x+y;};

        const subt=(x,y)=>{return x-y;};

        const mul= (x,y)=>{return x*y;};

        const div=(x,y)=>{return x/y;};

        function calculater(value){
                return value(10,20)
        }
        console.log('Values for your Option'+calculater(mul));
    }

    printNewArray(){
        let x=[10,20,30,40,50,2];
        let newArray=x.map((a)=>{return a+2;})
        newArray.forEach(values=>{console.log(values)});
    }

    printNegativeValues(){
        let x = [10, -2, -5, -8, 20, 33];
        let newArray = x.filter((n) => { return n < 0; });
        newArray.forEach((value) => {console.log(value);});
    }

    handleClick(){
        this.addValuesToTheArray();
    }
    handleClick2(){
        this.checkTheValuesPresentOrNotInTheArray();
    }
    handleClick3(){
        this.arithrmaticOperation();
    }
    handleClick4(){
        this.printNewArray();
    }
    handleClick5(){
        this.printNegativeValues();
    }
}