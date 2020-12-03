import Foundation

let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    guard
        let originalMethod = class_getInstanceMethod(forClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    else { return }
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

extension URLSession {
    @objc open func _dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        print(">> INTERCEPTED")
        Session.default.interceptor.intercept(urlRequest: request)
        return Session.default.dummyDataTask
    }
    
}

extension URLSessionDataTask {
    @objc open func _resume() {
        print("RESUME MONXTRO")
    }
}

class Swizzle {
    class func start() {
        print("SWIZZLE ON")
        let urlSessionInstance = URLSession.shared
        let uRLSessionDataTaskInstance = URLSessionDataTask()
        //todo fazer swizzle do URL -> URLSessionDataTask
        
        swizzling(
            URLSession.self,
            #selector(urlSessionInstance.dataTask(with:completionHandler:) as (URLRequest, @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask),
            #selector(urlSessionInstance._dataTask(with:completionHandler:) as (URLRequest, @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask)
        )
        
        swizzling(
            URLSessionDataTask.self,
            #selector(uRLSessionDataTaskInstance.resume),
            #selector(uRLSessionDataTaskInstance._resume)
        )
    }
    
    class func stop() {
        print("SWIZZLE OFF")
        let urlSessionInstance = URLSession.shared
        
        swizzling(
            URLSession.self,
            #selector(urlSessionInstance._dataTask(with:completionHandler:)),
            #selector(urlSessionInstance.dataTask(with:completionHandler:) as (URLRequest, @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask)
        )
        
//        swizzling(
//            URLSession.self,
//            #selector(urlSessionInstance._dataTask(with:)),
//            #selector(urlSessionInstance.dataTask(with:) as (URLRequest) -> URLSessionDataTask)
//        )
    }
}



/// swizzle
/*
 
open func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

open func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
 
             #selector(urlSessionInstance.dataTask(with:) as (URLRequest) -> URLSessionDataTask),
             #selector(urlSessionInstance._dataTask(with:))
*/
