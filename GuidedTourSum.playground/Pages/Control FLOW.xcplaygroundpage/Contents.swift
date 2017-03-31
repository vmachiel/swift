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
