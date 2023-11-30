import { LightningElement, track } from 'lwc';
import searchContractsByTenant from '@salesforce/apex/ContractSearch.searchContractsByTenant';
import searchContractsByBuilding from '@salesforce/apex/ContractSearch.searchContractsByBuilding';

export default class ContractSearch extends LightningElement {
    tenantName = '';
    buildingName = '';
    @track showdata = false;
    @track filteredData = [];
    @track columns = [
        { label: 'Tenant Name', fieldName: 'Customer_Signed_By__c' },
        { label: 'Building Name', fieldName: 'Building_Name__c' },
        { label: 'Contract Start Date', fieldName: 'Contract_Start_Date__c' },
        { label: 'Contract End Date', fieldName: 'Contract_End_Date__c' }, 
        { label: 'Lease amount', fieldName: 'Lease_Amount__c'}  
     ];

    handleTenantNameChange(event) {
        this.tenantName = event.target.value;
    }

    handleBuildingNameChange(event) {
        this.buildingName = event.target.value;
    }

    searchContractsByTenant() {
        if (this.tenantName) {
            searchContractsByTenant({ tenantName: this.tenantName })
                .then(result => {
                    this.filteredData = result;
                    this.showdata = true;
                    console.log('Contracts filtered successfully:', this.filteredData);
                })
                .catch(error => {
                    console.error(error);
                });
        } else {
            console.log('No input provided. Please enter a tenant name.');
            this.showdata = false;
        }
    }

    searchContractsByBuilding() {
        if (this.buildingName) {
            searchContractsByBuilding({ buildingName: this.buildingName })
                .then(result => {
                    this.filteredData = result;
                    this.showdata = true;
                })
                .catch(error => {
                    console.error(error);
                });
        } else {
            console.log('No input provided. Please enter a building name.');
            this.showdata = false;
        }
    }
}