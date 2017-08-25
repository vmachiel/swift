import UIKit

// init is a special method to initialize every property that wasn't inited
// by lazy, = value, being an optional, executing a closure. 
// There can be multiple inits: think of String. It has an init that takes a double,
// an init that takes another String and so on.
// Let's say you manage data, and you have to import some from time to time. If this
// takes a lot of resources, you only want to init your extensive DataImporter class,
// when necessary:

class DataImporter {
    
    var filename = "data.txt"
    
}

class DataManager {
    
    lazy var importer = DataImporter()
    var data = [String]()
    
}
let dataStorage = DataManager()
dataStorage.data.append("Some data.txt")
// Here, the DataImport class isn't used yet.
dataStorage.data.append(dataStorage.importer.filename)
// Now it is!


// Callers use inits by using your type's name and arguments if needed
let testNumber = String(45.2)
let emptyString = String()
// or var brain = CalculatorBrain()


// Some get init() for free:
// Base classes that don't inherit from anything get free init with no arguments

// Structs get a default init with all properties as the arguments
// So you don't write an init:
struct PendingBinaryOperation {
    var function: (Double, Double) -> Double
    var firstOperand: Double
}
// This gets a free init(function: (Double, Double) -> Double, firstOperand: Double {
// }
// Which is used by simply:
let pbo = PendingBinaryOperation(function: +, firstOperand: 3)
// The free one is GONE if you init one yourself: then you write them for everything!


// JUST REMEMBER, YOU CAN WRITE DIFFERENT INITS WITH DIFFERENT PARAMETERS. USER OF THE
// CLASS/STRUCT CAN CHOSE WHICH TO USE TO INIT. 



// WHAT TO DO IN INIT():
// Set property's value, even if it has a default.
// Set constant properties (let): Init can override a let default!
// Call other inits by things like self.init(args) or super.init()

// CLASS ONLY:
// You are required to init all of your vars by the time init is done.
// Two init types: convenience and not-convenience (designated, or REGULAR)
// Regular are the main one, convenience are secondary or "helper"
// A designated init can only call a designated init in it's immediate superclass
// You must init all properties introducted by your class before calling super.init
// You must call a super.init before you assign values to inherited properties.
// Convenience inits can only cal regular init in its own class
// Convenience init must call that init before setting properties on its own
// All init's must be done before calling methods or access properties.

// INHERIT INITS
// if you don't implement regular inits, you'll inherit superclass regulars.
// If you override all of your superclass regular init, you'll inherit the conve
// nience inits.
// If you don't implement any inits, you inherit everything.

// REQUIRED INITS
// you can mark your class init as required: any subclass must implement them (or inherit
// them).
// Failable init
// init?() may fail and are used with optionals. Example is Double(string value here), has
// one, incase the string can't be converted. The init will set the instance to nil.

// Overview of init and convenience init structure:
let image1 = UIImage(named: "initializerDelegation02_2x")
// So, basic inits, subclassing inits etc:
class NamedShape {
    var numberOfSides: Int = 0 // defined at declaration.
    var name: String // to be defined at initialization
    
    init(name: String) {
        self.name = name
    }
}

class Square: NamedShape {
    var sideLength: Double  // to be definied at init
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)  // pass the name to the init methods of NamedShape
        numberOfSides = 4
    }
    func area() -> Double{
        return sideLength * sideLength
    }
}

// Different inits based on arguments provided:
struct Color {
    
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

// Omitting labels, causing a different init:
struct Celsius {
    
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius(37.0)




// convenience inits and overriding init:
// If no parameter is given, the convenience init is used to call the init()
class Food {
    
    // Basic init:
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unnamed")
    }
}
let image2 = UIImage(named: "initializersExample01_2x")
// So now, if no name is given, the convenience init passed "unnamed" to the init method
let burger = Food(name: "Burger")
let someFood = Food()
burger.name
someFood.name
// Now define RecipeIngredient. This one has a new designated init, but overrides the con-
// venience one. The designated does call it's superclass for name.
class RecipeIngredient: Food {
    
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
// So now it looks like this:
let image3 = UIImage(named: "initializersExample02_2x")
// You can init in three ways now
// 1 (BLUE): Use the RecipeIngredients D init with parameters given:
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
// 2 (YELLO): Use the new overriden C init, which calls the D init with a default 
// quantity of 1:
let oneBacon = RecipeIngredient(name: "Bacon")
oneBacon.quantity
// 3 (RED): Provide no parameters. The convenience init will set quantity to 1. 
// The class also inherited all the C inits from superclasses, so it can also handle
// the no name provided case.
let oneMysteryItem = RecipeIngredient()
oneMysteryItem.name
oneMysteryItem.quantity


// Finally a shopplist is added: 
class ShoppingListItem: RecipeIngredient {
    
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
let image4 = UIImage(named: "initializersExample03_2x")
// It inherits ALL its inits: C no parameters, C name parameters, and D both parameters.
// And here is a use case: 
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true

for item in breakfastList {
    print(item.description)
}




// Default and delegated inits for value types!
// So, you don't have inheritance with structs. But let's say a struct has other structs 
// as properties. You can have a default init that just uses the other struct's inits, or
// you can define your own on top of that, and use that if certain parameters are provided.
// For example here: use a rectangle with default values of 0, define one by using the 
// origin and size, or define one use the center and size. 
struct Size {
    var width = 0.0
    var height = 0.0
}

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Rect {
    
    var origin = Point()
    var size = Size()
    init () {}  // default init, used when no parameters given
    
    // Init used when you provide an origin and a size
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    // Init used when you provide a center and a size:
    // This calls another init version using self!
    init(center: Point, size: Size){
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let somePoint = Point(x: 7, y: 4)
let someSize = Size(width: 4.5, height: 1.5)

// Default 0, 0 location rect with size 0.0
let boringRect = Rect()
// Rect defined by a origin and size:
let rect1 = Rect(origin: somePoint, size: someSize)
rect1.origin.x
rect1.origin.y
rect1.size.width
rect1.size.height
// Use the same point and size to define a rect with the point at the center: 
let rect2 = Rect(center: somePoint, size: someSize)
rect2.origin.x
rect2.origin.y
rect2.size.width
rect2.size.height


// Failible init
// You can write an init so that it can fail en return nil. The class/struct will be
// an optional:
struct Animal {
    
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}
let animal1 = Animal(species: "Cow")
type(of: animal1)
let animal2 = Animal(species: "")


// or do it with enums:
enum TemperatureUnit {
    
    case kelvin
    case celsius
    case fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let farhenheitUnit = TemperatureUnit(symbol: "F")
let unknownUnit = TemperatureUnit(symbol: "X")

// And with enums with raw values (characters in this case)
// They have a default init?(){}
enum TemperatureUnit2: Character {
    
    case kelvin = "K"
    case fahrenheit = "F"
    case celcius = "C"
    
}

let celciusUnit = TemperatureUnit2(rawValue: "C")
let someUnit = TemperatureUnit2(rawValue: "L")

// With classes, you can propegate failible inits through sublclasses:
class Product {
    
    var name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem: Product {
    
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}
// So now, if either an empty name is provided, or a negative/0 quantity, the object is
// not inited.
let twoSocks = CartItem(name: "Sock", quantity: 2)
let nothing = CartItem(name: "", quantity: 8)
let nothing2 = CartItem(name: "Something", quantity: -4)

// You can override a failible init with a non-failible one:

class Document {
    
    var name: String?
    init() {}
    
    init?(name: String) {
        if name.isEmpty {
           return nil
        }
        self.name = name
    }
}
// Override both the empty init (no argument provided) or the failible init with 1 arguemnt
class ActualDocument: Document {
    
    override init() {
        super.init()
        self.name = "No Title"
    }
    // call the empty init as super!
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "No Title"
        }
        self.name = name
    }
}

// Set default values of a class or struct with a closure or function.
// Instead of default value, or passing a parameter to init, provide a closuer/function
// Chessboard that computes black and white squares:
struct Chessboard {
    
    // Closure to init boardColors
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
board.squareIsBlackAt(row: 0, column: 1)
board.squareIsBlackAt(row: 2, column: 6)












