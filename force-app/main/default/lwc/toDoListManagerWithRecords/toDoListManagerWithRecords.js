import { createRecord, deleteRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import TASK_MANAGER_OBJECT from '@salesforce/schema/Task_Manager__c';
import TASK_ID from '@salesforce/schema/Task_Manager__c.Id';
import TASK_NAME from '@salesforce/schema/Task_Manager__c.Name';
import TASK_START_DATE from '@salesforce/schema/Task_Manager__c.Start_Date__c';
import TASK_COMPLETED_DATE from '@salesforce/schema/Task_Manager__c.Completed_Date__c';
import TASK_IS_COMPLETED from '@salesforce/schema/Task_Manager__c.Is_Completed__c';
import GETINCOMPLETEDRECORDS from '@salesforce/apex/TaskManagerController.getIncompletedTask';
import GETCOMPLETEDRECORDS from '@salesforce/apex/TaskManagerController.getcompletedTask';
import { refreshApex } from '@salesforce/apex'
import { LightningElement, wire } from 'lwc';

export default class ToDoListManagerWithRecords extends LightningElement {
    taskName = "";
    taskDate = null;
    inCompeltedTask = [];
    compeltedTask = [];
    inCompeltedTaskResponse = {};
    compeltedTaskResponse = {};

    @wire(GETINCOMPLETEDRECORDS)
    wireGetIncompletedTask(response) {
        this.inCompeltedTaskResponse = response;
        let { data, error } = response;
        if (data) {
            this.inCompeltedTask = data.map((currentItem) => ({
                taskId: currentItem.Id,
                taskname: currentItem.Name,
                taskdate: currentItem.Start_Date__c
            }))
        } else if (error) {
            console.log('ErrorCompletedTask' + error);
        }
    }

    @wire(GETCOMPLETEDRECORDS)
    wireGetCompletedTask(response) {
        this.compeltedTaskResponse = response;
        let { data, error } = response;
        if (data) {
            this.compeltedTask = data.map((currentItem) => ({
                taskId: currentItem.Id,
                taskname: currentItem.Name,
                taskdate: currentItem.Start_Date__c
            }))
        } else if (error) {
            console.log('ErrorCompletedTask' + error);
        }
    }

    onChangeHandler(event) {
        let { name, value } = event.target;
        if (name === 'taskname') {
            this.taskName = value;
        } if (name === 'taskdate') {
            this.taskDate = value;
        }
    }
    resetHandler() {
        this.taskName = "";
        this.taskDate = null;
    }

    createTaskHandler() {
        if (!this.taskDate) {
            this.taskDate = new Date().toISOString().slice(0, 10);
        }
        if (this.validateTask()) {

            let inputFields = {};
            inputFields[TASK_NAME.fieldApiName] = this.taskName;
            inputFields[TASK_START_DATE.fieldApiName] = this.taskDate;
            inputFields[TASK_IS_COMPLETED.fieldApiName] = false;

            let recordInput = {
                apiName: TASK_MANAGER_OBJECT.objectApiName,
                fields: inputFields
            };

            createRecord(recordInput)
                .then((result) => {
                    this.showToast("Success", "Task Created Successfully", "success")
                    this.resetHandler();
                    refreshApex(this.inCompeltedTaskResponse);
                })
                .catch((error) => {
                    this.showToast("Failed", "Unable To Create Task", "error")
                })
        }
    }

    validateTask() {
        let isValid = true;
        let element = this.template.querySelector(".taskname");
        // condition 1 -- check the task name is empty
        // condition 2 -- check the task name is repeted 
        if (!this.taskName) { // task name is empty
            isValid = false;
        } else {
            //find method will return true if it finds a value (if the 1st vakue is true it will not check second value)in array, 
            //if it not find it will return undefined
            let taskItem = this.inCompeltedTask.find((currentItem) =>
                currentItem.taskname === this.taskName && currentItem.taskdate === this.taskDate
            );
            if (taskItem) {
                isValid = false;
                // set custom validation on the input box if the task name already exist it will throw an error
                element.setCustomValidity("Task already exist");
            }
        }
        if (isValid) {
            element.setCustomValidity("");
        }
        element.reportValidity(); // to display the error message in the html
        return isValid;
    }

    deleteTaskHandler(event) {
        let recordId = event.target.name;

        deleteRecord(recordId)
            .then((result) => {
                this.showToast("Deleted", "Task Deleted Successfully", "success")
                refreshApex(this.inCompeltedTaskResponse);
            })
            .catch((error) => {
                this.showToast("Failed", "Unable To Delete Task", "error")
            })
    }

    completeTaskHandler(event) {
        let recordId = event.target.name;
        this.refresData(recordId);
    }

    dragHandler(event) {
        event.dataTransfer.setData("recordId", event.target.dataset.item);
    }

    allowDropHandler(event) {
        event.preventDefault();
    }

    onDropHandler(event) {
        let recordId = event.dataTransfer.getData("recordId");
        this.refresData(recordId);
    }

    async refresData(recordId) {

        let inputFields = {};
        inputFields[TASK_ID.fieldApiName] = recordId;
        inputFields[TASK_IS_COMPLETED.fieldApiName] = true;
        inputFields[TASK_COMPLETED_DATE.fieldApiName] = new Date().toISOString().slice(0, 10);

        let recordInput = {
            fields: inputFields
        };
        try {
            await updateRecord(recordInput);
            this.showToast("Updated", "Task Updated Successfully", "success");
            await refreshApex(this.inCompeltedTaskResponse);
            await refreshApex(this.compeltedTaskResponse);
        }
        catch (error) {
            console.log('Error While updating a record', JSON.stringify(error));
            this.showToast("Failed", "Unable To Update Task", "error")
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
}