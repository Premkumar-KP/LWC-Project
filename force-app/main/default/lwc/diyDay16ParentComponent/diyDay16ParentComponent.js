import { LightningElement } from 'lwc';

export default class DiyDay16ParentComponent extends LightningElement {
    message='Hi From Parent';

    messageFromChild;

    handleClickFromChild(event){
        this.messageFromChild=event.detail;
    }
}