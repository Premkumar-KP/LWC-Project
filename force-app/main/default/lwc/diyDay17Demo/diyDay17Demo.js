import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts'
export default class DiyDay17Demo extends LightningElement {

    accountsrecord
    error

    @wire(getAccounts)
    accountsrecord(result){
        if(result.data){
            this.accountsrecord=result.data;
            this.error=undefined;
        }
        else if(result.error){
            this.accountsrecord=undefined;
            this.error=result.error;
        }
    }
}