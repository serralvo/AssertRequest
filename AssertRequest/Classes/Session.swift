import Foundation

class Session {

    static let `default` = Session()
    var isRecording = false
    
    // MARK: - Components
    
    let interceptor = DataRequestInterceptor()
    let collector = RequestCollector()
    let differ: Differ
    let dummyDataTask = URLSessionDataTask.new()
    
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
