import XCTest
import AssertRequest
@testable import AssertRequest_Example

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    
    func test_viewController_makeDataRequest() {
        AssertRequest.startObserving()
        
        ViewController().didTouchMakeDataRequest()
        
        AssertRequest.assert()
    }
    
}
