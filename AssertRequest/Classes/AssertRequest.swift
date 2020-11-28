import XCTest

class AssertRequest {
    class func startObserving() {
        Session.default.startObserving()
    }
    
    class func assert() {
        let hasDiff = Session.default.differ.hasAnyDiff()
        XCTAssertFalse(hasDiff)
        Session.default.stopObserving()
    }
}
