import { LightningElement, wire} from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import GETOPENCASES from '@salesforce/apex/CaseController.getOpenCases';

export default class DisplayOpenCases extends LightningElement {

    CaseResponse;
    CaseRecords;

    @wire(GETOPENCASES)
    Wire_Case_Response(response) {
        this.CaseResponse = response;
        let { data, error } = response;
        if (data) {
            this.CaseRecords = data.map((rec)=>{
                let ageClass = '';
                if (rec.Age__c > 2) {
                    ageClass = 'highlightRed';
                } else {
                    ageClass = 'highlightOrange';
                }
                return { ...rec, ageClass: ageClass };
            });
        } if (error) {
            console.log(JSON.stringify(error));
        }
    }

    handleCloseCase(event) {
        const caseId = event.target.dataset.id;
        const fields = {
            Id : caseId,
            Status: 'Closed'
        };
        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                this.showToast('Success','Case Closed','success');
                 refreshApex(this.CaseResponse);
            })
            .catch((error) => {
                this.showToast('Failed','Unable to update a case','error');
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}