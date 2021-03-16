import Foundation

class Session {

    static let `default` = Session()
    var isRecording = false
    
    // MARK: - Components
    
    let interceptor = DataRequestInterceptor()
    let swizzle = Swizzle()
    var collector: RequestCollector?
    var differ: Differ?
//    let dummyDataTask = URLSessionDataTask.new()
    
    private init() {}
    
    // MARK: - Observing
    
    func startObserving(identifier: RequestIdentifier) {
        let collector = RequestCollector(identifier: identifier)
        differ = Differ(collector: collector)
        self.collector = collector
        swizzle.start()
    }
    
    func stopObserving() {
        swizzle.stop()
        collector?.clear()
    }
}
