// static properties and methods belong to a type like class or struct eg. 
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





/* Access. You can control the level of access.
Access control lets you specify what data inside structs and classes should be exposed to the outside world, and you get to choose four modifiers:
• Public: this means everyone can read and write the property.
• Internal: this means only your Swift code can read and write the property. If you ship
  your code as a framework for others to use, they won’t be able to read the property.
• File Private: this means that only Swift code in the same file as the type can read and
  write the property.
• Private: this is the most restrictive option, and means the property is available only
  inside methods that belong to the type.
*/
