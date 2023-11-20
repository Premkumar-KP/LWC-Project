import { LightningElement } from 'lwc';
import searchContact from '@salesforce/apex/ContactController.searchContact'
export default class DiyDay18Part1 extends LightningElement {

    contactRecords;
    errorMessage;
    contactName;

    handleClick(){
        
        this.contactName=this.template.querySelector('lightning-input').value;
       
        searchContact({name:this.contactName})

        .then((result)=>this.contactRecords=result)

        .catch((error)=>this.errorMessage=error)

    }
}