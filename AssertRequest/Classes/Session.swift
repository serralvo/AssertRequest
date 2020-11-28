import Foundation

class Session {

    static let `default` = Session()
    public var isRecording = false
    
    // MARK: - Components
    
    let interceptor = DataRequestInterceptor()
    let collector = RequestCollector()
    let differ: Differ
    
    private init() {
        differ = Differ(collector: collector)
    }
    
    // MARK: - Observing
    
    func startObserving() {
        Swizzle.start()
    }
    
    func stopObserving() {
        Swizzle.stop()
        collector.clear()
    }
}
