import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import Flat_Number from '@salesforce/schema/Flat__c.Flat_Number__c';
import Building_Code from '@salesforce/schema/Flat__c.Building_Code__c';
import price from '@salesforce/schema/Flat__c.Price_Per_Sqft__c';
import Status from '@salesforce/schema/Flat__c.Status__c';
import Floor from '@salesforce/schema/Flat__c.Floor__c';

export default class AddFlatComponent extends NavigationMixin(LightningElement) {

    FlatFields = [Building_Code, Flat_Number, Status, price, Floor];

    handleSuccess(event) {
        // Notify user of success
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Flat added successfully',
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);

        // Get the Id of the newly created record
        const recordId = event.detail.id;

        // Navigate to the record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Flat__c', 
                actionName: 'view',
            },
        });
    }
}
