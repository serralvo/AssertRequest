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
    
    private func hasDiff(diffable: Diffable) -> Bool {
        guard let recordedRequests = fileManager.retrieve(identifier: diffable.identifier) else {
            return true
        }

        return !recordedRequests.contains { $0 == diffable.request }
    }
}
