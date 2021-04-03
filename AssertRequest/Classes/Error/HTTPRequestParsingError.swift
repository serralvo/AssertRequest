enum HTTPRequestParsingError: Error {
    case noHTTPMethod
    case noURL
}

extension HTTPRequestParsingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noHTTPMethod:
            return "Sent request has no HTTP method set"
        case .noURL:
            return "Sent request has no URL set"
        }
    }
}
