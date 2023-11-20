import { LightningElement, api } from 'lwc';

export default class ChildProgressBar extends LightningElement {

    progress = 0; 

    @api handleStart() {

        console.log('Start from child')

        setInterval(() => {

            this.progress = this.progress + 10;
            if (this.progress >= 100) {
                const e = new CustomEvent('progressfinished')
                this.dispatchEvent(e);
            }

        }, 300)

        console.log('event dispatched from child')

    }

    handleClick() {



        //console.log("Event raised from child")
        //1. custom event

        // const e=new CustomEvent("display",{detail:"Test Data"}); passing one data

        const e = new CustomEvent("display",
            {
                detail: { code: 101, name: 'John' }
            });

        //2. dispatch event

        this.dispatchEvent(e)


    }

}