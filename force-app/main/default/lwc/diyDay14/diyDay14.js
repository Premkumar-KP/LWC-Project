import { LightningElement } from 'lwc';

export default class DiyDay14 extends LightningElement {

    openingBalance=50000;
    enteredAmount=0;
    handleClick(event){
        this.enteredAmount=parseInt(event.target.value);
    }

    handleClickDeposit(){
        this.openingBalance+=this.enteredAmount;
    }
    handleClickWithdraw(){
        this.openingBalance-=this.enteredAmount;
    }
}