class RequestCollector {
    
    private(set) var requests: [Diffable] = []
    private(set) var errors: [Error] = []
    private let fileManager = FileManagerHandler()
    
    var identifier: RequestIdentifier?
    
    func append(urlRequest: URLRequest) {
        guard let identifier = self.identifier else {
            return registerError(error: InternalError.noIdentifierSetOnCollector)
        }
        do {
            let request = try Request(urlRequest: urlRequest)
            
            requests.append(
                .init(
                    identifier: identifier,
                    request: request
                )
            )
        } catch {
            return registerError(error: error)
        }
    }
    
    func clear() throws {
        if Session.default.isRecording {
            try fileManager.store(diffableList: requests)
            return
        }
        requests.removeAll()
        errors.removeAll()
    }
    
    func registerError(error: Error) {
        errors.append(error)
    }
}
