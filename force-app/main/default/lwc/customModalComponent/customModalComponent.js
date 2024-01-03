import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import ID from '@salesforce/schema/Lead.Id';
import NAME from '@salesforce/schema/Lead.Name';
import RATING from '@salesforce/schema/Lead.Rating';
import STATUS from '@salesforce/schema/Lead.Status';
import EMAIL from '@salesforce/schema/Lead.Email';
import COMPANY from '@salesforce/schema/Lead.Company';

export default class CustomModalComponent extends LightningElement {
    @api isEditMode = false;
    @api isCreateMode = false;
    @api recordId;
    @api displayModal;

    leadFields = [ID, NAME, EMAIL, COMPANY, RATING, STATUS];

    get header() {
        if (this.isEditMode) return 'Edit Lead';
        else if (this.isCreateMode) return 'New Lead';
        else return '';
    };
    onCloseHandler() {
        let myCustomEvent = new CustomEvent("closemodal")
        this.dispatchEvent(myCustomEvent);
    }

    newHandleSuccess() {
        this.showToast('Success', 'Lead Record Created Successfully', 'success');
        this.sendSuccessEvent();
        this.onCloseHandler();
    }

    editHandleSuccess() {
        this.showToast('Success', 'Lead Record Updated Successfully', 'success');
        this.sendSuccessEvent();
        this.onCloseHandler();
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    sendSuccessEvent(){
        let myCustomEvent = new CustomEvent("successevent")
        this.dispatchEvent(myCustomEvent);
    }
}