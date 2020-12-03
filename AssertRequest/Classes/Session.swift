import Foundation

class Session {

    static let `default` = Session()
    var isRecording = false
    
    // MARK: - Components
    
    let interceptor = DataRequestInterceptor()
    var collector: RequestCollector?
    var differ: Differ?
    let dummyDataTask = URLSessionDataTask.new()
    
    private init() {}
    
    // MARK: - Observing
    
    func startObserving(identifier: RequestIdentifier) {
        let collector = RequestCollector(identifier: identifier)
        differ = Differ(collector: collector)
        self.collector = collector
        Swizzle.start()
    }
    
    func stopObserving() {
        Swizzle.stop()
        collector?.clear()
    }
}
