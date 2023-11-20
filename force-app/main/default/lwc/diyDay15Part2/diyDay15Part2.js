import { LightningElement,track } from 'lwc';

export default class DiyDay15Part2 extends LightningElement {
    @track courses=['9.am Break Fast','1.pm Lunch','9.pm Dinner','12.am Sleep'];
    courseName="";

    handleClickInput(event){
        this.courseName=event.target.value;
    }

    handleClickAdd(){
        this.courses=[...this.courses,this.courseName];
    }

    handleClickDelete(event){
       // alert(event.target.parentElement.dataset.value);
        const userInput = event.target.parentElement.dataset.value;
        this.courses = this.courses.filter(toDoValues => toDoValues !== userInput);
    }
}