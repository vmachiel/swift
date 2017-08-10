// Let's say we have a Person class, and a Macbook class. The Person points to the 
// Macbook class, because he owns it. The Macbook points to the person as it's owner.
// You have a loop here: even if the Person is set to nil, there is still a second 
// reference to it from the Macbook, so it'll never deinit. The Macbook is
// (1) reference and the Person itself is another (2)

// To fix this, make the reference from the Macbook to the Person weak. As long as
// the Person is around, the Macbook will and can refer to it. But it won't count in
// the Automatic Reference Counting, or ARC. So the count will be 1: the Person itself.

// As soon as the Person is de-inited, the count will be 0 and resources will be freed. 

class Person {
    
    let name: String
    var macbook: Macbook?
    
    init(name: String, macbook: Macbook?) {
        self.name = name
        self.macbook = macbook
    }
    
    deinit {
        print("The person called \(name) has been deinitialized")
    }
    
}


class Macbook {
    
    let name: String
    weak var owner: Person?
    
    init(name: String, owner: Person?) {
        self.name = name
        self.owner = owner
    }
    
    deinit {
        print("The product called \(name) has been deinitialized")
    }
    
}

// So each one may either have a reference to another instance of not (optional)
// As you can see, the reference from Macbook to Person has been made weak. So, Macbook
// refering to Person doesn't count in terms of reference cycles.
// So here they aren't pointing at all.
var machiel: Person? = Person(name: "Machiel", macbook: nil)
var macbookPro: Macbook? = Macbook(name: "machielvandorst", owner: nil)

// set the references and if you denit machiel:
machiel?.macbook = macbookPro
macbookPro?.owner = machiel

machiel = nil









