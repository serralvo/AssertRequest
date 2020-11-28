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
        guard let data = fileManager.retrieve(identifier: diffable.identifier) else {
            return true
        }
        
        let recordedCurl = String(data: data, encoding: .utf8)
        let newCurl = diffable.request.curlString
        
        return recordedCurl != newCurl
    }
}
