import { LightningElement } from 'lwc';

export default class DiyDay9 extends LightningElement {

    printOddNumbersInArray(){
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        for (let i = 0; i < numbers.length; i++) {
        if (numbers[i] % 2 !== 0) {
            console.log(numbers[i]);
        }
        }
    }

    sumOfEvenNumbersInArray(){
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        let sum = 0;
        for (let i = 0; i < numbers.length; i++) {
        if (numbers[i] % 2 === 0) {
            sum += numbers[i];
        }
        }
            console.log("Sum of even numbers:", sum);
    }

    countNegativeNumbersinArray(){
        let numbers = [1, -2, 3, -4, 5, -6, 7, 8, -9, 10];
        let count = 0;

        for (let i = 0; i < numbers.length; i++) {
        if (numbers[i] < 0) {
            count++;
        }
        }
        console.log("Number of negative numbers:", count);
    }

    countTotalNumbersInArray(){
        let arrayvalues = [10, 'AJ Skill', 'Demo', true, 20,false];
        let count = 0;
        for (let i = 0; i < arrayvalues.length; i++) {
        if (typeof arrayvalues[i] === 'number') {
            count++;
        }
        }
        console.log("Total numbers in the array:", count);
    }

    totalNumbersInStringAndPrint(){
        let str = "Hai Welcome 100 to JS 5";
        let words = str.split(" ");
        let numbers = [];
        let count = 0;
        for (let i = 0; i < words.length; i++) {
        if (!isNaN(words[i])) {
            numbers.push(words[i]);
            count++;
        }
        }
        let numbersString = numbers.join(",");
        console.log("Numbers from the string:", numbersString);
        console.log("Total numbers in the string:", count);
    }

    handleClick(){
       this.printOddNumbersInArray();
    }
    handleClick2(){
       this.sumOfEvenNumbersInArray();
    }
    handleClick3(){
        this.countNegativeNumbersinArray();
    }
    handleClick4(){
        this.countTotalNumbersInArray();
    }
    handleClick5(){
        this.totalNumbersInStringAndPrint();
    }
}