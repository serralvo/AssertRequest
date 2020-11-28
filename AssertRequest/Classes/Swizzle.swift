import Foundation

let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    guard
        let originalMethod = class_getInstanceMethod(forClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    else { return }
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

extension URLSession {
    @objc func _dataTask(with urlRequest: URLRequest) -> URLSessionDataTask {
        Session.default.interceptor.intercept(urlRequest: urlRequest)
        return URLSessionDataTask()
    }
}

class Swizzle {
    class func start() {
        let urlSessionInstance = URLSession()
        swizzling(
            URLSession.self,
            #selector(urlSessionInstance.dataTask(with:) as (URLRequest) -> URLSessionDataTask),
            #selector(urlSessionInstance._dataTask(with:))
        )
    }
    
    class func stop() {
        let urlSessionInstance = URLSession()
        swizzling(
            URLSession.self,
            #selector(urlSessionInstance._dataTask(with:)),
            #selector(urlSessionInstance.dataTask(with:) as (URLRequest) -> URLSessionDataTask)
        )
    }
}
