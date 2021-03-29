struct URLSessionUploadTaskWithStreamedRequest: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.uploadTask(withStreamedRequest:) as (URLRequest) -> URLSessionUploadTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._uploadTaskWithStreamedRequest(withStreamedRequest:) as (URLRequest) -> URLSessionUploadTask)
    }
    
    var type: AnyClass = URLSession.self
}

extension URLSession {
    @objc open func _uploadTaskWithStreamedRequest(withStreamedRequest: URLRequest) -> URLSessionUploadTask {
        Session.default.interceptor.intercept(urlRequest: withStreamedRequest)
        return Session.default.dummyUploadTask
    }
}
