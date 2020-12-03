protocol MethodSelector {
    var originalMethod: Selector { get }
    var swizzledMethod: Selector { get }
    var type: AnyClass { get }
}
