struct URLSessionDataTaskMethodResume: MethodSelector {
    let uRLSessionDataTaskInstance = URLSessionDataTask()
    
    var originalMethod: Selector {
        #selector(uRLSessionDataTaskInstance.resume)
    }
    
    var swizzledMethod: Selector {
        #selector(uRLSessionDataTaskInstance._resume)
    }
    
    let type: AnyClass = URLSessionDataTask.self
}

extension URLSessionDataTask {
    @objc open func _resume() {
        // no action
    }
}
