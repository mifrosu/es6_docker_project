"use strict";

function fizzbuzz(number) {
    let out = []
    for (let value of [...Array(number).keys()]) {
        if (value === 0 || value % 3 && value % 5) {
            out.push(value);
        } else {
            out.push((value % 3 ? "" : "Fizz") + (value % 5 ? "": "Buzz"));
        }
    }
    return out;
}

console.log(fizzbuzz(16));
