import { LightningElement } from 'lwc';

export default class DiyDay15Part3 extends LightningElement {
    employees = [
        { name: 'Metha', position: 'Developer', salary: 230000, isWorking: true },
        { name: 'Prem', position: 'Developer', salary: 230000, isWorking: false },
        { name: 'Muthu', position: 'Developer', salary: 230000, isWorking: true }
    ];

    get workingEmployees() {
        return this.employees.filter(employee => employee.isWorking);
    }

    get nonWorkingEmployees() {
        return this.employees.filter(employee => !employee.isWorking);
    }
}
