// STATIC
// Type properties and methods belong to a type like class or struct eg.
// class PersonClass instead of an instance of a type like
// var x = PersonClass(name: "Harry"), you do this to store shared data for example:
// Or shared methods.
class TaylorFan {
    static var favoriteSong = "Shake it off"
    static func singFavoriteSong() {
        print("I'm gonna \(favoriteSong), \(favoriteSong) Yeah Yeah Yeah")
    }
    
    init(name:String, age: Int) {
        self.name = name
        self.age = age
    }
    
    var name: String
    var age: Int
    
    func printNameAndAge() {
        print("My name is \(name), and I'm \(age) years old")
    }
}
let harry = TaylorFan(name: "Harry", age: 23)
harry.printNameAndAge()
// harry.favoriteSong won't work because it belongs to the struct, now the instance
TaylorFan.favoriteSong
TaylorFan.singFavoriteSong()

// Built in lib has a lot of static, like Double:
let d = Double.pi  // static property
// You can't call these on 3.45425 for instance because that is an instance of Double

// Another example of type properties, this time with a struct. Let's say you have
// the volume of an audio Channel. You want the a max volume, which would be the same
// for all channels. And you want to keep track of the max volume set by users across
// all channels. Also, if the set level turns out to be higher then the thresehold,
// set it to threshold. And it it's higher than maxInputSet, update that.
struct AudioChannel {
    
    static let thresholdLevel = 10
    static var maxInputSet = 0
    
    var currentLevel: Int = 0 {
        
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputSet {
                AudioChannel.maxInputSet = currentLevel
            }
        }
    }
}
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
// set leftChannel to 7. The maxInputSet of the class will now by 7 as well,
// even though rightChannel never set it.
leftChannel.currentLevel = 7
AudioChannel.maxInputSet
// Set rightChannel to 11. The classes thresholdLevel will prevent that and set it
// to 10. maxInput will be updated as well.
rightChannel.currentLevel = 11
rightChannel.currentLevel
AudioChannel.maxInputSet




// Type Methods are also a thing! 
// With class, use the class keyword again:
class Car {
    
    class func honkTheHorn() {
        print("Beep Beep ")
    }
}
Car.honkTheHorn()


// With structs use the static keyword again:
// Here is an example of a game with shared progress. When ever one person unlocks a level
// all people (instances) can play it:
// NOTE: The @discardableResults is there so the compiler won't warn when you don't do
// anything with the false return. But you can use this somewhere else if you want to
// check if advance has worked or not
struct LevelTracker {
    
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
// Use type methods like this:
class Player {
    
    var tracker = LevelTracker()
    let playerName: String
    
    init(name: String) {
        self.playerName = name
    }
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
}

var machielPlayer = Player(name: "Machiel")
machielPlayer.complete(level: 1)
// Display what level is unlocked:
LevelTracker.highestUnlockedLevel
// Players share unlock
var otherPlayer = Player(name: "snor")
if otherPlayer.tracker.advance(to: 6) {
    print("Level 6 is good to go")
} else {
    print("you haven't reach this level yet")
}






// LAZY:
// Lazy properties aren't set until they are accessed by another property of method
// So until someone creates and instance of SuperTaylorFan, and access property,
// the var is not set.
class SuperTaylorFan: TaylorFan {
    
    var fanStatus = "Super Mega Fan!"
    lazy var basedOnThisPerson = harry
}

let harry2 = SuperTaylorFan(name: "Harry", age: 23)
// Still not set. Now, if I do this:
harry2.basedOnThisPerson
// The property is set

// You do this to delay expensive operations. Like calculator brain: let's set it's HUGE
// and it's a value type as we know. Maybe don't set it in the viewController until it's
// necessary.
// Another reason to use them is: In swift, every var needs to be initialized. So
// if you have a huge class or struct, you have to init everything before you can even
// send a message. Even within your own class/struct. Initing everything when you don't
// need to can be expensive, so you can use lazy if you want.

// Or what if a property you want to init needs to call a method to do so.
// You can't call methods until every thing else has been inited: use lazy.
// That lazy property can't be accessed anyway until everything has been inited. And
// lazy "count as inited" also, so you can use it on multiple vars!!

// You can also lazy init with a closure, which is run when something access the var.
// lazy var someProperty: Type = { closure code that returns value of type Type }()
// NOTICE THE PARANTS!! Execute when access.




// SELF
// You don't have to write self in a struct/class: swift will use instance properties 
// automatically. Only when a parameter name in a method is the same as a instance
// property, will swift give the parameter preference. You'll have to prefix the property
// with self. 

// Use them in init:
class Lamp {
    
    let typeOfBulp: String
    let maxWattage: Double
    var state = "on"
    
    init(_ typeOfBulp: String, strength maxWattage: Double) {
        self.typeOfBulp = typeOfBulp
        self.maxWattage = maxWattage
    }
    
    func description() {
        print("The is a \(typeOfBulp) lamp, its \(maxWattage) watts and it's \(state).")
    }
    
}
let lamp = Lamp("LED", strength: 12)
lamp.state = "off"  // REMEMBER: it's let so constant, but only a reference, so mutable!
lamp.description()


// You can also use self to assign new values in a mutating method:
struct Point {
    
    var x = 0.0
    var y = 0.0
    
    // x is parameter, self.x is current property
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
    
    // Here the x is the self.x and deltaX is the parameter in the second line!
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
somePoint.moveBy(x: 9.0, y: 1.1)


// And use them in enums like this: 
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}



/* Access. You can control the level of access.
Access control lets you specify what data inside structs and classes should be exposed to the outside world, and you get to choose four modifiers:
• Public: this means everyone can read and write the property.
• Internal: this means only your Swift code can read and write the property. If you ship
  your code as a framework for others to use, they won’t be able to read the property.
• File Private: this means that only Swift code in the same file as the type can read and
  write the property.
• Private: this is the most restrictive option, and means the property is available only
  inside methods that belong to the type. Swift 4: AND EXTENSIONS!
*/


// Subscript can be used to define your own subscripts to access data, like the i in 
// Array[i] or the key in Dictionary[key]
// Example:
struct TimesTable {
    
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTable = TimesTable(multiplier: 3)
threeTable[5]

// You can also define types that take multiple subscripts, like a matrix:
struct Matrix {
    
    let totalRows: Int
    let totalColumns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.totalRows = rows
        self.totalColumns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    // A check to prevent out of bounds
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < totalRows && column >= 0 && column < totalColumns
    }
    
    // This basically converts the double index i, j that you give a matrix to a 
    // single index to use internally. Define what happens when you set or get the 
    // double index
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            // Notice!! row given * TOTAL columns + row given
            return grid[(row * totalColumns) + row]
        }
        set {
            assert(indexIsValid(row: row, column: column))
            // Notice!! row given * TOTAL columns + row given
            grid[row * totalColumns + row] = newValue
        }
    }
}

var testMatrix = Matrix(rows: 2, columns: 3)
testMatrix[0,0] = 3
testMatrix[1,2] = -2
print(testMatrix)






















