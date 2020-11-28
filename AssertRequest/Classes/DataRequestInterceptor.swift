import Foundation

class DataRequestInterceptor {
    let fileManager = FileManagerHandler()
    
    func intercept(urlRequest: URLRequest) {
        guard let data = urlRequest.curlString.data(using: .utf8) else {
            return print("Error")
        }
        
        guard !Session.default.isRecording else {
            fileManager.store(data: data, identifier: .init())
            return
        }
        
        Session.default.collector.append(.init(), request: urlRequest)
    }
}
