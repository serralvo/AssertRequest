struct URLSessionDataTaskWithURLCompletion: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.dataTask(with:completionHandler:) as (URL, @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._dataTaskWithURL(with:completionHandler:) as (URL, @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask)
    }
    
    let type: AnyClass = URLSession.self
}

extension URLSession {
    @objc open func _dataTaskWithURL(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let urlRequest = URLRequest(url: url)
        Session.default.interceptor.intercept(urlRequest: urlRequest)
        return Session.default.dummyDataTask
    }
}
