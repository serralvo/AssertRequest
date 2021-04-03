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
        
        let collector = Session.default.collector
        guard AssertRequest.handleSessionErrorAndReturnIsInvalid(collector: collector, file: file, line: line) else { return }
        if Session.default.isRecording {
            do {
                try Session.default.stopObserving()
                XCTFail("Requests recorded! Set recording to false and run again.", file: file, line: line)
            } catch {
                XCTFail(error.localizedDescription, file: file, line: line)
            }
        } else {
            do {
                let hasDiff = try Session.default.differ.hasAnyDiff()
                try Session.default.stopObserving()
                XCTAssertFalse(hasDiff, file: file, line: line)
            } catch {
                XCTFail(error.localizedDescription, file: file, line: line)
            }
        }
    }
    
    private class func handleSessionErrorAndReturnIsInvalid(collector: RequestCollector, file: StaticString, line: UInt) -> Bool {
        guard collector.errors.isEmpty else {
            let errorMessage = collector.errors.reduce ("") { text, error in "\(text); \(error.localizedDescription)" }
            XCTFail("The following errors occured during test time: \(errorMessage)")
            return false
        }
        guard collector.requests.isEmpty == false else {
            XCTFail("No request was identified during the test", file: file, line: line)
            return false
        }
        return true
    }
}
