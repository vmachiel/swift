// Attributes provide info about a declaration or type
// You mark them @attributeinfo above the declaration, like you would use decorators in
// Python.

// Example: Mark as deprated. Xcode will give a warning if called.
@available(*, deprecated, message: "Don't use anymore")
func printDoubleOfInt(_ number: Int) {
    print("\(number * 2)")
}

printDoubleOfInt(8)

// Be more specific:
@available(iOS, deprecated: 10.0, obsoleted: 11.0, message: "Because I said so")
func printTripleOfInt(_ number: Int) {
    print("\(number * 3)")
}

printTripleOfInt(8)



