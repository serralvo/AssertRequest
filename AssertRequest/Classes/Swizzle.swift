import Foundation

let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    guard
        let originalMethod = class_getInstanceMethod(forClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    else { return }
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

class Swizzle {
    
    private let methodsToSwizzle: [MethodSelector] = [
        URLSessionMethodDataTask(),
        URLSessionDataTaskMethodResume(),
    ]
    
    func start() {
        for method in methodsToSwizzle {
            performSwizzling(on: method, shouldInvert: false)
        }
    }
    
    func stop() {
        for method in methodsToSwizzle {
            performSwizzling(on: method, shouldInvert: true)
        }
    }
    
    private func performSwizzling(on method: MethodSelector, shouldInvert: Bool) {
        if shouldInvert {
            swizzling(
                method.type,
                method.originalMethod,
                method.swizzledMethod
            )
        } else {
            swizzling(
                method.type,
                method.swizzledMethod,
                method.originalMethod
            )
        }
    }
}

//        swizzling(
//            URLSession.self,
//            #selector(urlSessionInstance._dataTask(with:)),
//            #selector(urlSessionInstance.dataTask(with:) as (URLRequest) -> URLSessionDataTask)
//        )

/// swizzle
/*
 
open func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

open func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
 
             #selector(urlSessionInstance.dataTask(with:) as (URLRequest) -> URLSessionDataTask),
             #selector(urlSessionInstance._dataTask(with:))
*/
