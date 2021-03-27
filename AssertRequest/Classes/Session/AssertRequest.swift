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
        guard Session.default.collector?.get().isEmpty == false else {
            return XCTFail("No request was identified during the test", file: file, line: line)
        }
        if Session.default.isRecording {
            do {
                try Session.default.stopObserving()
                XCTFail("Requests recorded! Set recording to false and run again.", file: file, line: line)
            } catch {
                XCTFail(error.localizedDescription, file: file, line: line)
            }
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
