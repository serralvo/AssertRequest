struct RequestIdentifier {
    let testName: String
    let file: String
    let fileExtension: String = "json"
    
    init(
        testName: String,
        file: String
    ) {
        var test = testName
        test.removeLast(2) // removes brackets ()
        self.testName = test
        self.file = file
    }
}

extension RequestIdentifier: Equatable {}
