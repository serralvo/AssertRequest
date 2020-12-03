import XCTest

open class AssertRequest {
    open class func startObserving(
        recording: Bool = false,
        file: StaticString = #file,
        function: StaticString = #function
    ) {
        Session.default.isRecording = recording
        Session.default.startObserving(identifier: .init(testName: function, file: file, fileExtension: "json"))
    }
    
    open class func assert() {
        let hasDiff = Session.default.differ?.hasAnyDiff() ?? true
        XCTAssertFalse(hasDiff)
        Session.default.stopObserving()
    }
}
