// Standard controll flow: If, else, for. If must be a Boolean, no implicit comparisons

let individualScores = [41, 53, 78, 84, 39]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

// You can also use the for-in combo to loop over dictionaries just like python for k,v in dict

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25]
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

// You can also use optionals: values that are either "there" or nil. 
// State in the declaration if the variable is optional.
var optionalString: String? = "Hello"
print(optionalString == nil)  // false
if let greeting = optionalString{
    print("You greeted me, thanks!")
} else {
    print("You jerk!)")
}
optionalString = nil
if let greeting = optionalString{
    print("You greeted me, thanks!")
} else {
    print("You jerk!)")
}

// You can also provide a default using ?? If the optional value is missing
// the default one is used.
let nickName: String? = nil
let fullName: String = "Machiel van Dorst"
let informalGreeting = "Hi \(nickName ?? fullName)" // nickName is empty so fullName is used

// Switch statements aren't bound to one variable type, or true/false, ints only etc. 
// They need to be exhaustive: include a default case! If a match is found, the code after 
// the : is executed and the program exits the switch block.

let vegetable = "red pepper"

switch vegetable {  // let's look at vegetable

case "celery":  // is it "celery"?
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":  // is it a list of "cucumber", "watercress"
    print("That would make a good tea sandwich.")
// This one is interesting: if vegetable ends in pepper (it does), "red pepper" is assigened to local
// variable x and can be used in the following statement
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}




