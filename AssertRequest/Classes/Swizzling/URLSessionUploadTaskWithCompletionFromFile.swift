struct URLSessionUploadTaskWithCompletionFromFile: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.uploadTask(with:fromFile:completionHandler:) as (URLRequest, URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._uploadTaskWithCompletionFromFile(with:fromFile:completionHandler:) as (URLRequest, URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask)
    }
    
    var type: AnyClass = URLSession.self
}

extension URLSession {
    @objc open func _uploadTaskWithCompletionFromFile(with: URLRequest, fromFile: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        Session.default.interceptor.intercept(urlRequest: with)
        completionHandler(nil, nil, nil)
        return Session.default.dummyUploadTask
    }
}
