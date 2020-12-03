import XCTest
import AssertRequest
@testable import AssertRequest_Example

class Tests: XCTestCase {

    func test_viewController_makeDataRequest() {
        AssertRequest.startObserving(recording: true)
        
        ViewController().didTouchMakeDataRequest()
        
        AssertRequest.assert()
    }
}
