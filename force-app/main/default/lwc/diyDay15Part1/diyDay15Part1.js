import { LightningElement } from 'lwc';

export default class DiyDay15Part1 extends LightningElement {

    courses=['Apex','VF','Flows','Aura'];
    courseName="";

    handleClickInput(event){
        this.courseName=event.target.value;
    }

    handleClickAdd(){
        this.courses=[...this.courses,this.courseName];
    }

    handleDivClick(event){
        alert(event.target.dataset.value)
    }
}