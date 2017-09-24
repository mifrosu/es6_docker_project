"use strict";

function isPalindrome(word) {
    let test_word = word.toLowerCase().replace(/[^\w]/g, "")
    return test_word === test_word.split("").reverse().join("");
}

function testPalindrome(word) {
    console.log(`isPalindrome("${word}"): ${isPalindrome(word)}`)
}

const test_strings = [
    "Bolton", "Hanna", "Sir, I demand, I am a maid named Iris."
];

for (let str of test_strings) {
    testPalindrome(str)
}
