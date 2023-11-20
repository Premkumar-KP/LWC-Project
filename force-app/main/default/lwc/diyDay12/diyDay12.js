import { LightningElement } from 'lwc';

export default class DiyDay12 extends LightningElement {
    
    multlipicationArray(){
        let array = [2, 3, 4, 5];
        let multiplication = array.reduce((accumulator, currentValue) => accumulator * currentValue, 1);
        console.log("Multiplication Value is :",multiplication);
    }

    studentsArrayObject(){

        const students = [
            { name: "Sandy", department: "IT", result: "Pass" },
            { name: "Surya", department: "Electronics", result: "Fail" },
            { name: "Naveen", department: "Mechanical", result: "Pass" }
        ];

        console.log("Total number of students:", students.length);
        
        console.log("Passed students:");
        students.forEach(student => {
            if (student.result === "Pass") {
            console.log(student.name);
            }
        });
        
        students.forEach(student => {
            student.department = "CS";
        });
        console.log("Updated Department:");
      students.forEach(student=> {
         console.log("Student Name :",student.name,", Department :",student.department); 
      });
    }

    addFeesPropertytoStudents(){

        const students = [
            { name: "John", department: "IT", result: "Pass" },
            { name: "Sarah", department: "Electronics", result: "Fail" },
            { name: "Michael", department: "Mechanical", result: "Pass" }
        ];
        
        const studentsWithFeesProperty = students.map(student => {
            return { ...student, feesPaid: "Paid" };
        });
        
        console.log("Students with fees property:");  
        studentsWithFeesProperty.forEach(student=>{
            console.log("Student Name :",student.name,", Department :",student.department,
            ", Fees :",student.feesPaid);
        })
    }

    handleClick(){
        this.multlipicationArray();
    }
    handleClick2(){
        this.studentsArrayObject();
    }
    handleClick3(){
        this.addFeesPropertytoStudents();
    }
}