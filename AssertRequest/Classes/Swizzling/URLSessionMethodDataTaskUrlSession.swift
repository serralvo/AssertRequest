struct URLSessionMethodDataTaskUrlSession: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.dataTask(with:) as (URLRequest) -> URLSessionDataTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._dataTask(with:) as (URLRequest) -> URLSessionDataTask)
    }
    
    let type: AnyClass = URLSession.self
}

extension URLSession {
    @objc open func _dataTask(with urlRequest: URLRequest) -> URLSessionDataTask {
        Session.default.interceptor.intercept(urlRequest: urlRequest)
        return URLSessionDataTask()
    }
}
