enum FileError: Error {
    case cantWrite(error: Error, documentPath: String)
    case cantRead(error: Error, documentPath: String)
}

extension FileError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cantRead(let error, let documentPath):
            return "Cant read file at \(documentPath) with error \(error.localizedDescription)"
        case .cantWrite(let error, let documentPath):
            return "Cant write to or create file at \(documentPath) with error \(error.localizedDescription)"
        }
    }
}
