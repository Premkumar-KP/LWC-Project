import { LightningElement } from 'lwc';

export default class DiyDay14Part2 extends LightningElement {

    output="";
    value1=0;
    value2=0;
    value3=0;

    handleClickInput(event){
        if(event.target.name=='Input1'){
            this.value1=parseInt(event.target.value);
        } else if(event.target.name=='Input2'){
            this.value2=parseInt(event.target.value);
        } else if(event.target.name=='Input3'){
            this.value3=parseInt(event.target.value);
        }
    }

    handleClickOutput(){

            if(this.value1 > this.value2 && this.value1 > this.value3) {
                this.output="value 1  is the greatest";
            } else if (this.value2 > this.value3) {
                this.output="value 2 is the greatest";
            } else {
                this.output="value 3 is the greatest";
            }
          }
}