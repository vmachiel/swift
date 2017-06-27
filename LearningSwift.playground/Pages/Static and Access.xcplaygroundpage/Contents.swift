// static properties and methods belong to a type like class or struct eg. struct PersonClass
//, instead of an instance of a type like var x = PersonClass(name: "Harry")
// You do this to store shared data for example:
struct TalorFan {
    static var favoriteSong = "Shake it off"
    
    var name: String
    var age: Int
}

let harry = TalorFan(name: "harry", age: 23)
// harry.favoriteSong won't work because it belongs to the struct, now the instance
TalorFan.favoriteSong


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