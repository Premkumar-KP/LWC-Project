import { LightningElement } from 'lwc';

export default class Diyday14Part3 extends LightningElement {

    output=0;
    value1=0;
    value2=0;

    handleClickInput(event){
        if(event.target.name=='Input1'){
            this.value1=parseInt(event.target.value);
        } else if(event.target.name=='Input2'){
            this.value2=parseInt(event.target.value);
        }
    }

    handleClicAddition(){
        this.output=this.value1 + this.value2;
    }
    handleClickSubtraction(){
        this.output = this.value1 - this.value2;
    }
    handleClickMultiplication(){
        this.output= this.value1 * this.value2;
    }
    handleClickDivision(){
        this.output= this.value1 / this.value2;
    }
}