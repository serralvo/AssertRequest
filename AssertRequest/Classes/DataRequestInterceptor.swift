import Foundation

class DataRequestInterceptor {
    let fileManager = FileManagerHandler()
    
    func intercept(urlRequest: URLRequest) {

        do {
            let request = try Request(urlRequest: urlRequest)
            
            guard Session.default.isRecording == false else {
                fileManager.store(request: request, identifier: .init())
                return
            }
            
            Session.default.collector.append(.init(), request: urlRequest)
        } catch {
            //todo: handle this error
            return print(error.localizedDescription)
        }
    }
}
