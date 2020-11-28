import XCTest

open class AssertRequest {
    open class func startObserving(recording: Bool = false) {
        Session.default.isRecording = recording
        Session.default.startObserving()
    }
    
    open class func assert() {
        let hasDiff = Session.default.differ.hasAnyDiff()
        XCTAssertFalse(hasDiff)
        Session.default.stopObserving()
    }
}
