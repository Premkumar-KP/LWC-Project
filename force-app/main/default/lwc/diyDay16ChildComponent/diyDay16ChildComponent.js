import { LightningElement, api } from 'lwc';

export default class DiyDay16ChildComponent extends LightningElement {
    @api messagefromparent
    handleClick(){
        const event = new CustomEvent ("selectclick",{
            detail: 'Hi this is a child component message' })
            this.dispatchEvent(event);
    }
}