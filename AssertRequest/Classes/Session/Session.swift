import Foundation

class Session {

    static let `default` = Session()
    var isRecording = false
    
    // MARK: - Components
    
    let interceptor = DataRequestInterceptor()
    let swizzle = Swizzle()
    var collector = RequestCollector()
    lazy var differ = Differ(collector: collector)
    let dummyDataTask = URLSessionDataTask.new()
    let dummyUploadTask = URLSessionUploadTask.new()
    
    private init() {}
    
    // MARK: - Observing
    
    func startObserving(identifier: RequestIdentifier) {
        collector = RequestCollector()
        differ = Differ(collector: collector)
        swizzle.start()
    }
    
    func stopObserving() throws {
        swizzle.stop()
        try collector.clear()
    }
}
