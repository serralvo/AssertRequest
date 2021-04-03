enum InternalError: Error {
    case noIdentifierSetOnCollector
}

extension InternalError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noIdentifierSetOnCollector:
            return "Internal framework error: No Identifier set on Collector. Verify module initialization."
        }
    }
}
