import { LightningElement, wire, track } from 'lwc';
import GETALLLEADRECORDS from '@salesforce/apex/LeadController.getLeadRecords';
import ID from '@salesforce/schema/Lead.Id';
import NAME from '@salesforce/schema/Lead.Name';
import RATING from '@salesforce/schema/Lead.Rating';
import STATUS from '@salesforce/schema/Lead.Status';
import EMAIL from '@salesforce/schema/Lead.Email';
import COMPANY from '@salesforce/schema/Lead.Company';


export default class CreateAccountAndContactForLead extends LightningElement {

    leadRecordResponse;
    leadRecords;
    selectedLeadId;
    showNewRecord=false;
    showEditRecord=false;

    leadFields=[ID,NAME,EMAIL,COMPANY,RATING,STATUS];

    columnsList = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email' },
        { label: 'Rating', fieldName: 'Rating' },
        { label: 'Lead Status', fieldName: 'Status' },
    ];

    @wire(GETALLLEADRECORDS)
    Wire_leadRecordsResponse(response) {
        this.leadRecordResponse = response;
        let { data, error } = response;
        if (data) {
            this.leadRecords = data;
        } if (error) {
            console.log(JSON.stringify(error));
        }
    }

    handleclickNew() {
        this.showNewRecord=true;

    }

    handleclickEdit() {
        this.showEditRecord=true;
    }


    handleSelect(event) {
        let selectedItem = event.detail.selectedRows;
        if (selectedItem) {
            this.selectedLeadId=selectedItem[0].Id;
        } 
    }

    handleSuccess(){
        this.showToast('Success','Lead Record Created Successfully','success');
    };

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

}