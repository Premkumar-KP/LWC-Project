import { LightningElement, api } from 'lwc';

export default class ParentprogressBar extends LightningElement {

    handleClick()
   {

    console.log("start is clicked in parent ")
     this.template.querySelector("c-child-progress-bar").handleStart();
     
     this.template.querySelector("lightning-button").disabled=true;

   }



    handleDisplay(event) {

       // console.log("Parent hand for child event")

        //console.log(event.detail)

       // console.log(event.detail.code)
        //console.log(event.detail.name)

    }

    handleFinish(event)
    {
        this.template.querySelector("lightning-button").disabled=false;
    }


}