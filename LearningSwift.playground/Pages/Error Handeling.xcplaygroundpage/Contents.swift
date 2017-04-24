// Error handeling is often done by creating an enum that adopts the error protocol
enum PrinterError: Error {
    case outOfPaper
    case outOfToner
    case onFire
}

