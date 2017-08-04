import Foundation

// UserDefaults is a tiny lightweight database that persists. Great for settings, don't use
// it for mucht more! 

// It stores Property Lists which are a combination of: Array, Dictionary, String, Date,
// Data, and numbers like Int. It's an old Obj-C API so uses type any (Swift would use
// protocols
// It has a set function: func set(Any?, forkey: String)
// And a get function:    func get(forkey: String) -> Any? 
// In both cases, Any? has to be a type listed above ^

// Create one by using its standard property:
let defaults = UserDefaults.standard
// Set like so: everything set has to be a part of the property list explained above.
// Clear and entry with nil
defaults.set(3.14149, forKey: "Pi")
defaults.set([1, 2, 3, 4, 5], forKey: "My Array")   // Int and Array are property list
defaults.set("Some Text", forKey: "Some Setting")
defaults.set(nil, forKey: "Some Setting")

// Why is this not working
let numberPi = defaults.double(forKey: "Pi")




