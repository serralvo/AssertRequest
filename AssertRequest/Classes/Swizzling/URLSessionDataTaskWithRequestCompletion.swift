struct URLSessionDataTaskWithRequestCompletion: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.dataTask(with:completionHandler:) as (URLRequest, @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._dataTask(with:completionHandler:) as (URLRequest, @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask)
    }
    
    let type: AnyClass = URLSession.self
}

extension URLSession {
    @objc open func _dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        Session.default.interceptor.intercept(urlRequest: request)
        completionHandler(nil, nil, nil)
        return Session.default.dummyDataTask
    }
}
