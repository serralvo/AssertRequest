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
            
            guard Session.default.isRecording == false else {
                fileManager.store(request: request, identifier: identifier)
                return
            }
            
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
    
    func clear() {
        requests.removeAll()
    }
}

struct Diffable {
    let identifier: RequestIdentifier
    let request: Request
}
