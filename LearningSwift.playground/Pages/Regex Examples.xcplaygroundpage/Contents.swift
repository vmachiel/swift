import Foundation

// String will get some beautification code using Regex. Extention is used
// because it might be needed again.
// Regex takes a pattern and options, can throw error.
// Range is made by counting the caracters in the string the method is done
// on. This is the range the of the string that should be checked (all of it here)
// Finally, the result is return onto itself (this is a method)
// The pattern (regex constant) is replaced with the provided replacement template.
// This will be used in cases where the full string needs to be replaced.. i think.
extension String {
    
    func replace(pattern: String, with replacement: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSMakeRange(0, self.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacement)
    }
}

// The extention that's used by the viewcontroller. It replaces the pattern with the
// substring. So, \\. finds the dot, then none or one or more 0's, then either no number
// at all [^0-9] or the end of the string. So it find .0 or .00 or .0000 etc
// but not .00004 or .000423000243. It replaces that with $1, which is nothing so an
// empty string. So it replaces it with an empty string, effectively deleting it.
extension String {
    
    func beautifyNumbers() -> String {
        return self.replace(pattern: "\\.0+([^0-9]|$)", with: "S1")
    }
}

extension String {
    
    func removeNumbers() -> String {
        return self.replace(pattern: "[0-9]+", with: "S1")
    }
}

extension String {
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}


var testString = "Hello Snor Barry 23.000"
testString.removeNumbers()
testString.beautifyNumbers()









