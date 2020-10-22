// Today's Workshop/Agenda

// 1) Go over JavaScript's `this` keyword

// 2) ES6 spread syntax... Shallow Copy vs Deep Copy


// This

// const monkey = {
//   name: 'george',
//   eat: function() {
//     console.log('nom nom nom')
//   },
//   printThis: function() {
//     console.log('logging this within the monkey object')
//     console.log(this)
//   },
// }

// const fruit = {
//   name: 'apple'
// }

// monkey.bindedFunction = monkey.printThis.bind(fruit);

// console.log(monkey)

// monkey.printThis(); // when we use the keyword `this` within a method... The value of `this` refers to the object that owns the method


// function printThisInsideOfFunction() {
//   console.log(this) // the value of `this` within a regular function will refer to the global object
// }

// printThisInsideOfFunction();

// function a(fn) {
//   fn()
// }

// a(monkey.printThis) // passing monkey.printThis as just a function

// console.log('---------------------------------------')
// a(monkey.bindedFunction) // 


// Spread syntax Shallow copy vs Deep copy


// Arrays and Objects within Javascript are mutable. Because they keys within the objects refer to values

const fruit = {
  name: 'apple',
  age: 4,
  owner: {
    name: 'brandon'
  },
  id: 'a',
}


function makeChange(o) {
  console.log(o);
  o.id = 'b'
  o.owner.name = 'andy'
}

// mutating
// const fruitCopy = Object.assign({}, fruit); // Only Shallow Copies
// const fruitCopy = JSON.parse(JSON.stringify(fruit))

// spread operator docs https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax

const fruitCopy = {...fruit};

console.log('logging fruit copy ------------------------------')
console.log(fruitCopy);
console.log('------------------------------')

console.log('fruit before')
console.log(fruit);
makeChange(fruitCopy)
console.log('fruit after')
console.log(fruit);


// object destructuring syntax
const { name, age } = fruit;
console.log(name);
console.log(age);

const [index_0, index_1] = ['hello', 'world'];
console.log(index_0);
console.log(index_1);