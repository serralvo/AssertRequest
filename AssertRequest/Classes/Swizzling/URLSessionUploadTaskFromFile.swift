struct URLSessionUploadTaskFromFile: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.uploadTask(with:fromFile:) as (URLRequest, URL) -> URLSessionUploadTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._uploadTaskFromFile(with:fromFile:) as (URLRequest, URL) -> URLSessionUploadTask)
    }
    
    var type: AnyClass = URLSession.self
}

extension URLSession {
    @objc open func _uploadTaskFromFile(with: URLRequest, fromFile: URL) -> URLSessionUploadTask {
        Session.default.interceptor.intercept(urlRequest: with)
        return Session.default.dummyUploadTask
    }
}
