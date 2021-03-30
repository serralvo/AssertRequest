struct URLSessionUploadTaskFromBodyData: MethodSelector {
    let urlSessionInstance = URLSession.shared
    
    var originalMethod: Selector {
        #selector(urlSessionInstance.uploadTask(with:from:) as (URLRequest, Data) -> URLSessionUploadTask)
    }
    
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._uploadTaskFromBodyData(with:from:) as (URLRequest, Data) -> URLSessionUploadTask)
    }
    
    var type: AnyClass = URLSession.self
}

extension URLSession {
    @objc open func _uploadTaskFromBodyData(with: URLRequest, from: Data) -> URLSessionUploadTask {
        Session.default.interceptor.intercept(urlRequest: with, bodyData: from)
        return Session.default.dummyUploadTask
    }
}
