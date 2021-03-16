import Foundation

class DataRequestInterceptor {
    func intercept(urlRequest: URLRequest) {
        Session.default.collector?.append(urlRequest: urlRequest)
        
    }
}
