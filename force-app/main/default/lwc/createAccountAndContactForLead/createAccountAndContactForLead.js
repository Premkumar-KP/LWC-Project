import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

import GETALLLEADRECORDS from '@salesforce/apex/LeadController.getLeadRecords';

export default class CreateAccountAndContactForLead extends LightningElement {

    leadRecordResponse;
    leadRecords;
    selectedLeadId;
    newMode = false;
    editMode = false;
    showModal = false;

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
        this.newMode = true;
        this.showModal = true;
    }

    handleclickEdit() {
        this.editMode = true;
        this.showModal = true;
    }

    async handleclickDelete() {
        try {
            await deleteRecord(this.selectedLeadId);
            this.showToast('Success', 'Lead Record Deleted Successfully', 'success');
            await refreshApex(this.leadRecordResponse);
        } catch (error) {
            this.showToast('Error', error.body.message, 'error');
        }
    }

    handleSelect(event) {
        let selectedItem = event.detail.selectedRows;
        if (selectedItem) {
            this.selectedLeadId = selectedItem[0].Id;
        }
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    handleCloseModal() {
        this.showModal = false;
        this.newMode = false;
        this.editMode = false;
    }

    successHandler() {
        refreshApex(this.leadRecordResponse);
    }
}