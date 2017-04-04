import UIKit

// Basic operators:
var a = 10
a = a + 1
a = a - 1
a = a * 2
a = a / 2

var b = 13 / 3 // floor devision, won't do float automatically because strong typing!
b = b % 3  // modulus or remain

// Like python, you can shorten the x = x + 10 thing
b = 10
b += 10
b -= 10

// adding doubles
var c = 1.1
var d = 2.2
var e = c + d

// String concatination
var name1 = "Machiel van Dorst"
var name2 = "Annabel Dellebeke"
var bothNames = name1 + " en " + name2

// comparison operators that return Booleans:
e > 3
e < 3
e <= 3
e >= 3
e == 3
e != 3
name1 == "Machiel van Dorst" // true!

// Use the ! operator before any Boolean to flip it:
var stayOutTooLate = true // true
!stayOutTooLate // false

// Interpolation: basically python f-strings. Do in place calculations and manipulation of
// variables and convert them into String, and print out the whole thing.
// More efficient than concatinating, and allows for calculations
var name = "Machiel van Dorst"
"Your name is \(name)"
// Another example:
var age = 29
var latitude = 51.16643

print("Your name is \(name) and your age is \(age) and you're at latitude \(latitude)")
print("In three years time, you'll be \(age + 3) years old")

// Array operation:
var songs = ["Shake it Off", "You Belong with Me", "Back to December"]
var songs2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs + songs2

songs += ["Snorsex"]
