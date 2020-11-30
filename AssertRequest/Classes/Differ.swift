import Foundation

class Differ {
    
    let collector: RequestCollector
    
    init(collector: RequestCollector) {
        self.collector = collector
    }
    
    var fileManager = FileManagerHandler()
    
    func hasAnyDiff() -> Bool {
        for diffable in collector.get() {
            if hasDiff(diffable: diffable) { return true }
        }
        
        return false
    }
    
    //todo: throw inexistent file exception
    private func hasDiff(diffable: Diffable) -> Bool {
        guard let recordedRequest = fileManager.retrieve(identifier: diffable.identifier) else {
            return true
        }
        
        do {
            let newRequest = try Request(urlRequest: diffable.request)
            return newRequest != recordedRequest
        } catch {
            //todo: handle error
            print(error.localizedDescription)
            return false
        }
    }
}
