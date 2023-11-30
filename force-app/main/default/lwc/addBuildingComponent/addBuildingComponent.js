import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Building__c.Building_Name__c';
import Number_units from '@salesforce/schema/Building__c.Number_Of_Units__c';
import Total_Floor from '@salesforce/schema/Building__c.Total_Floor__c';
import Total_Area_in_Acres from '@salesforce/schema/Building__c.Total_Area_in_Acres__c';

export default class AddBuildingComponent extends NavigationMixin(LightningElement) {

    buildingFields = [NAME_FIELD, Number_units, Total_Floor,Total_Area_in_Acres];

    handleSuccess(event) {
        // Notify user of success
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Building added successfully',
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
                objectApiName: 'Building__c', // API name of the object
                actionName: 'view',
            },
        });
    }
}
