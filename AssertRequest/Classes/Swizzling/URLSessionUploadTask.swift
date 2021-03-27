struct URLSessionUploadTaskWithCompletion: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.uploadTask(with:from:completionHandler:) as (URLRequest, Data?, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._uploadTaskWithCompletion(with:from:completionHandler:) as (URLRequest, Data?, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask)
    }
    
    var type: AnyClass = URLSession.self    
}

extension URLSession {
    @objc open func _uploadTaskWithCompletion(with: URLRequest, from: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        Session.default.interceptor.intercept(urlRequest: with)
        completionHandler(nil, nil, nil)
        return Session.default.dummyUploadTask
    }
}
