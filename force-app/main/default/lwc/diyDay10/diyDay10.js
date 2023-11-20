import { LightningElement } from 'lwc';

export default class DiyDay10 extends LightningElement {

    checkTheCourseNameInArray(){
        let courses = ['Apex', 'VF', 'Aura', 'LWC'];
        let courseName = 'Flow';
        if (!courses.includes(courseName)) {
            courses.push(courseName);
                    }
        courses.forEach(values=>console.log(values))
    } 

    checkEmployeePresentOrNot(){
        let employees = ['John', 'Sureh', 'Lewis', 'Veera'];
        let employeeName = 'Peter';
        if (employees.includes(employeeName)) {
            console.log(employeeName + ' is present.');
        } else {
            console.log(employeeName + ' is not present.');
        }
    }

    replaceNegativeValuesWithZero(){
        let x = [10, -5, -3, 20, 60];
        for (let i = 0; i < x.length; i++) {
        if (x[i] < 0) {
            x[i] = 0;
        }
        }
        x.forEach(values=>console.log(values))
    }

    handleClick(){
        this.checkTheCourseNameInArray();
    }
    handleClick2(){
        this.checkEmployeePresentOrNot();
    }
    handleClick3(){
        this.replaceNegativeValuesWithZero();
    }
}