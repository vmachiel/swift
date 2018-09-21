// Take this stuct:
struct Rectangle {
    var height: Int
    var width: Int
}
// You can use extensions to organize and divide up your code. So you define the core
// stuff in the struc for example, and write some extension (after you import it or 
// whatever) to add func.
// You can extend its functionality like this:
extension Rectangle {
    var area: Int {
        return height * width
    }
    func fitsInside(_ other: Rectangle) -> Bool {
        return (width < other.width) && (height < other.height)
    }
}

// You can extend standlib, foundation etc. See protocols as well. 
// Can't have storage, or reimplement existing stuff.

extension String {
    func reverseString() -> String {
        var result = ""
        for letter in self {
            result.insert(letter, at: result.startIndex)
        }
        return result
    }
}

let word = "Test"
word.reverseString()
