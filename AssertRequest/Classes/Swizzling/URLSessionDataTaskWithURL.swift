struct URLSessionDataTaskWithURL: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.dataTask(with:) as (URL) -> URLSessionDataTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._dataTaskWithURL(with:) as (URL) -> URLSessionDataTask)
    }
    
    let type: AnyClass = URLSession.self
}

extension URLSession {
    @objc open func _dataTaskWithURL(with url: URL) -> URLSessionDataTask {
        let urlRequest = URLRequest(url: url)
        Session.default.interceptor.intercept(urlRequest: urlRequest)
        return Session.default.dummyDataTask
    }
}
