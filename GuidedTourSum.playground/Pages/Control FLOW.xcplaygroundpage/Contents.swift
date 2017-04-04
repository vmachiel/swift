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
