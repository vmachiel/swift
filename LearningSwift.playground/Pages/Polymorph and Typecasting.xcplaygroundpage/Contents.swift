// When a class B inherits from another A, you can treat it a if it where type
// B or A. Even though it's technically B, it inherits from A so it can be treated
// as if it where type A if you want. 

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The \(name) did pretty good"
    }
    
    // both work, but use the first one if you can.
    func getPerformance2() -> String {
        return "The \(self.name) did pretty good"
    }
}
// Use self.property in these cases!
// 1: When using closures (which are similar to objective c blocks), you
// will need to use it to acknowledge that self has been captured
// 2: When you are writing init functions to clarify you want to write to
// the instance variables from the similarly named init parameters
// 3: When you're assigning self to a variable, such as when assigning this object
// as the delegate of something else
class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio:String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album called \(name) sold a lot!"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album called \(name) sold a lot!"
    }
}

var masterOfPuppets = StudioAlbum(name: "Master of pupputs", studio: "No idea")
var sAndM = LiveAlbum(name: "S and M", location: "San Fransisco")
var stAnger = StudioAlbum(name: "St. Anger", studio: "Presidio")

// These are a mix of StudioAlbums, and LiveAlbums: But you can cast them all in an
// array as a Album type. 
var allAlbums: [Album] = [masterOfPuppets, sAndM, stAnger]
type(of: allAlbums)
type(of: allAlbums[1])  // It's elements are still of the declared type
// when you call the getPerformance on all the elements of the array, each will call
// their own overriden function. 
for album in allAlbums {
    print(album.getPerformance())
    print(type(of: album))
}



// Now, this only works in some cases. Swift treats them al Album s but they are really
// their subclasses. They happen to all have a getPerformance method. But if you loop 
// over them again accessing their studio property, code will fail because only StudioAblum
// has that property. Swift thinks everything is an Album because you said it was. 
// If you use subclasses, you might run into a situation where you use a subclass that
// is missing a certain method or property, and thus your code will fail.

// You can use downcasting, either optional with 'as?' or forced with 'as!'. 
// You are telling the compiler: I said this type was A before but it's actually B.
// Ex: I said it was all Album types, but it's actually LiveAlbum types. 

// So it's like optionals with the as? kind: if you can convert this type (or, 
// if this type turns out to be this other type), it works and the optional has a value. 
// If not it's nil. So you can use if let to unwrap it, or do nothing if nil

// Optional Casting: 
for album in allAlbums {
    // So if the current album in the loop can be downcasted ('converted') into a
    // StudioAlbum type (it's not nil), assign it to studioAlbum and run code.
    if let studioAlbum = album as? StudioAlbum {
        // You KNOW this will work because the it converted and succesfully unwrapped
        print(studioAlbum.studio)
    }
    if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}
// Force Casting:

// Using as! will forcefully convert types: it will assume it's actually the type you
// specify and convert. It won't return an optional because you are sure. It will crash
// if you are wrong!
var someAlbums: [Album] = [masterOfPuppets, stAnger]
// AGAIN, both are assumed by the compiler to be Album, but these two are actually 
// StudioAlbum
for album in someAlbums {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}
// You can also downcast as part of the loop, making it a bit more efficient
for album in someAlbums as! [StudioAlbum] {
    print(album.studio)
}


// Finally, force convert types using built-in functions
let number = 5
let numberText = String(number)















