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
// Another for loop trick: use .. to make an half-closed range of indexes like this. 
// 4 is not included.
var total = 0
for i in 0..<4 {  // for i = 0, 1, 2, 3 so four times.
    total += 1
}
print(total)
// make a closed range like this
var sum = 0
for i in 0...5 {  // for i = 0, 1, 2, 3, 4, 5 so six times.
    sum += 1
}
print(sum)
// Finally: use _ if you don't need to use the counter:
for _ in 1...5 {
    print("hello")
}
// Half closed ranges are great for looping over two arrays at once using an index
// This is because arrays count from 0
var people = ["Barry", "Larry", "Harry"]
var actions = ["bli bli bli", "lie lie lie", "hie hie hie"]
for i in 0..<people.count {
    print("\(people[i]) is gonna \(actions[i])")
}
// or loops inside loops
for i in 0..<people.count{
    var str = "\(people[i]) is gonna "
    
    for _ in 0...4 {
        str += "\(actions[i]) "
    }
    print(str)
}


// while loops: you can do them in two ways:
// Check condition first
var n = 2
while n < 100 {
    n *= 2
}
print(n)
// Check condition after
var m = 2
repeat {
    m *= 2
} while m < 100
print(m)
// Keep looping until you hit a break
var counter = 0
while true {
    counter += 1
    print("The counter is now \(counter)")
    if counter == 21 {
        break
    }
}

// continue skips just exits this iteration of the for or while loop and moves 
// to the next one.
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print("The odd numbers are: ")
for x in numbers {
    if x % 2 == 0 {
        continue
    }
    print(x)
}


// You can also use optionals: values that are either "there" or nil. 
// State in the declaration if the variable is optional.
var optionalString: String? = "Hello! "
print(optionalString == nil)  // false
// To perform an action if optionalString is not nil, use if let syntax
if let greeting = optionalString{
    //  if the optionalString exists (no nil) and thus can be set to greeting
    print("You greeted me, thanks!")
    // You can use the new constant greeting in this case:
    print("You said: \(greeting)")
} else {
    print("You jerk!)")
}
optionalString = nil
if let greeting = optionalString{
    print("You greeted me, thanks!")
    print("You said: \(greeting)")
} else {
    print("You jerk!)")
}
// You can also provide a default using ?? If the optional value is missing
// the default one is used.
let nickName: String? = nil
let fullName: String = "Machiel van Dorst"
let informalGreeting = "Hi \(nickName ?? fullName)"
// nickName is empty so fullName is used




// Switch statements aren't bound to one variable type, or true/false, ints only etc. 
// They need to be exhaustive: include a default case! If a match is found, the code after 
// the : is executed and the program exits the switch block.
// It needs to be complete! Either a default case, or all possible cases must be exhausted.
let vegetable = "red pepper"
switch vegetable {  // let's look at vegetable
case "celery":  // is it "celery"?
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":  // is it a list of "cucumber", "watercress"
    print("That would make a good tea sandwich.")
// This one is interesting: if vegetable ends in pepper (it does), "red pepper" 
// is assigened to local variable x (let) and can be used in the following statement
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

// You can also use ranges
var age = 29
switch age{
case 1:
    print("Happy first birthday")
case 13...19:   // A range including 13, 14, 15, 16, 17, 18, 19
    print("Happy birthday teenager")
case let decade where decade % 10 == 0:
    // so again: temp constant decade, if decade % 10 == 0
    print("Happy \(decade)th birthday!")
default:
    print("Happy birthday")
}

// You can also switch over multiple variables using tuples
let userName = "admin"
let passwordIsValid = true
switch (userName, passwordIsValid) {
case ("admin", true):
    print("Welcome back admin")
// You can also write an _ to indicate that the case of one of the variables doesn't matter
// so this matches all "guest" userName, regardless of the value of passwordIsValid.
case ("guest", _):
    print("Access denied, no guests allowed.")
// this is interseting: use an _ for userName to match any and assign the 
// second to variable isValid. 
// If it's true, return message after the ? if false, return after the :
// notice that admin, true and guest, true/false won't match here, because they've been
// matched before.
case (_, let isValid):
    print(isValid ? "Welcome to restricted area" : "Access Denied")
}

// Fallthrough can be used if you want the switch case to continue, even if
// you find a match. 
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)







