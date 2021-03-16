class RequestCollector {
    
    private var requests: [Diffable] = []
    private let fileManager = FileManagerHandler()

    private let identifier: RequestIdentifier
    
    init(identifier: RequestIdentifier) {
        self.identifier = identifier
    }
    
    func append(urlRequest: URLRequest) {
        do {
            let request = try Request(urlRequest: urlRequest)
            
            requests.append(
                .init(
                    identifier: identifier,
                    request: request
                )
            )
        } catch {
            //todo: handle
            print(error.localizedDescription)
            return
        }
    }
    
    func get() -> [Diffable] {
        return requests
    }
    
    func clear() throws {
        if Session.default.isRecording {
            try fileManager.store(diffableList: requests)
            return
        }
        requests.removeAll()
    }
}
