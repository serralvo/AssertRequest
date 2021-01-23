import XCTest
import AssertRequest
@testable import AssertRequest_Example

class Tests: XCTestCase {

    func test_viewController_didTouchMakeDataRequest_expectMakingMatchingRequest() {
        AssertRequest.startObserving(recording: true)
        
        ViewController().didTouchMakeDataRequest()
        
        AssertRequest.assert()
    }
}
