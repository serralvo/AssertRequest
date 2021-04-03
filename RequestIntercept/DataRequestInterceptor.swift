import Foundation

class DataRequestInterceptor {
    func intercept(urlRequest: URLRequest, bodyData: Data? = nil) {
        var request = urlRequest
        if let data = bodyData {
            request.httpBody = data
        }
        Session.default.collector.append(urlRequest: request)
    }
}
