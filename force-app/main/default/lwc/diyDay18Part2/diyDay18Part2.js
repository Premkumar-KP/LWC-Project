import { LightningElement,wire } from 'lwc';
import createAccount from '@salesforce/apex/AccountController.createAccount'



export default class DiyDay18Part2 extends LightningElement {

    name;
    phone;
   
    handleClick(event){
        this.name = this.template.querySelector('.Name').value;
        this.phone = this.template.querySelector('.Phone').value;

        createAccount({name: this.name, phone: this.phone})

        .then(response=>{
            console.log(response);
        })
        .catch(error=>{
            console.log(error);
        })
    }  
}