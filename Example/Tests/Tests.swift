import XCTest
import AssertRequest
@testable import AssertRequest_Example

class Tests: XCTestCase {

    func test_viewController_didTouchMakeDataRequest_expectMakingMatchingRequest() {
        AssertRequest.startObserving(recording: false)

        ViewController().didTouchMakeDataRequest()

        AssertRequest.assert()
    }

    func test_viewController_didTouchMakeChainedRequests_expectMatchingRequest() {
        let expectation = XCTestExpectation()
        AssertRequest.startObserving(recording: false)

        ViewController().didTouchMakeChainedRequests()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            AssertRequest.assert()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
}
