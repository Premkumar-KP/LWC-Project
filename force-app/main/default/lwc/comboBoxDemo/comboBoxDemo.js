import { LightningElement, api, wire } from 'lwc';



import { getPicklistValues, getObjectInfos, getObjectInfo } from 'lightning/uiObjectInfoApi';

import INDUSTRY_FIELDS from '@salesforce/schema/Account.Industry';

export default class comboBoxDemo extends LightningElement {

    //1. get record type id
    //2. get picklist info


    recordTypeId;
    industryOptions;
    value = "Education";

    @wire(getObjectInfo, { objectApiName: 'Account' })

    getObjectData({ data, error }) {
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;
            console.log(this.recordTypeId)

        }

    }

    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: INDUSTRY_FIELDS })

    getPicklistData({ data, error }) {
        if (data) {

            //loop -for each, for in, for, map - modify the array value and return

            this.industryOptions = data.values.map(d => {

                return { label: d.label, value: d.value }

            })
            console.log(this.industryOptions)

        } else if (error) {
            console.error('Error:', error);
        }
    }

    handleChange(event) {

        this.value = event.detail.value

    }

}