import XCTest

open class AssertRequest {
    open class func startObserving(
        recording: Bool = false,
        file: String = #file,
        function: String = #function
    ) {
        Session.default.isRecording = recording
        Session.default.startObserving(
            identifier: .init(
                testName: function,
                file: file
            )
        )
    }
    
    open class func assert(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        if Session.default.isRecording {
            XCTFail("Requests recorded! Set recording to false and run again.", file: file, line: line)
        } else {
            do {
                let hasDiff = try Session.default.differ?.hasAnyDiff() ?? true
                try Session.default.stopObserving()
                XCTAssertFalse(hasDiff, file: file, line: line)
            } catch {
                XCTFail(error.localizedDescription, file: file, line: line)
            }
        }
    }
}
