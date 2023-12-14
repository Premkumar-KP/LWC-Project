import { LightningElement } from 'lwc';

export default class ToDoListManager extends LightningElement {
    taskName = "";
    taskDate = null;
    inCompeltedTask = [];
    compeltedTask = [];

    onChangeHandler(event) {
        let { name, value } = event.target;
        if (name === 'taskname') {
            this.taskName = value;
        } if (name === 'taskdate') {
            this.taskDate = value;
        }
        console.log(this.taskName);
        console.log(this.taskDate);
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
            this.inCompeltedTask = [...this.inCompeltedTask, {
                taskname: this.taskName,
                taskdate: this.taskDate
            }];
            this.resetHandler();
            console.log('BeforeSortingInCompletedTask' + this.inCompeltedTask);
            let sortedArray = this.sortArray(this.inCompeltedTask);
            this.inCompeltedTask = [...sortedArray];
            console.log('InCompletedTask' + this.inCompeltedTask);
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

    sortArray(inputArray) {
        let sortbydate = inputArray.sort((a, b) => {
            const date1 = new Date(a.taskdate);
            const date2 = new Date(b.taskdate);
            return date1 - date2;
        });
        return sortbydate;
    }

    deleteTaskHandler(event) {
        let index = event.target.name;
        this.inCompeltedTask.splice(index, 1);
        let sortedArray = this.sortArray(this.inCompeltedTask);
        this.inCompeltedTask = [...sortedArray];
        console.log('InCompletedTask' + this.inCompeltedTask);
    }

    completeTaskHandler(event) {
        let index = event.target.name;
        this.refresData(index);
    }

    dragHandler(event) {
        event.dataTransfer.setData("index", event.target.dataset.item);
    }

    allowDropHandler(event) {
        event.preventDefault();
    }

    onDropHandler(event) {
        let index = event.dataTransfer.getData("index");
        this.refresData(index);
    }

    refresData(index) {
        let removedItem = this.inCompeltedTask.splice(index, 1);
        let sortedArray = this.sortArray(this.inCompeltedTask);
        this.inCompeltedTask = [...sortedArray];
        this.compeltedTask = [...this.compeltedTask, removedItem[0]];
    }
}