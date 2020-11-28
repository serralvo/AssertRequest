class RequestCollector {
    
    private var requests: [Diffable] = []
    
    func append(_ identifier: RequestIdentifier, request: URLRequest) {
        requests.append(
            .init(
                identifier: identifier,
                request: request
            )
        )
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
    let request: URLRequest
}
