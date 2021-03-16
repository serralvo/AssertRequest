import Foundation

class Differ {
    
    let collector: RequestCollector
    
    init(collector: RequestCollector) {
        self.collector = collector
    }
    
    var fileManager = FileManagerHandler()
    
    func hasAnyDiff() throws -> Bool {
        for diffable in collector.get() {
            if try hasDiff(diffable: diffable) { return true }
        }
        
        return false
    }
    
    private func hasDiff(diffable: Diffable) throws -> Bool {
        guard let recordedRequests = try fileManager.retrieve(identifier: diffable.identifier) else {
            return true
        }

        return !recordedRequests.contains { $0 == diffable.request }
    }
}
