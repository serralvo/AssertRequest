struct RequestIdentifier {
    let testName: String
    let file: StaticString
    let fileExtension: StaticString = "json"
    
    init(
        testName: String,
        file: StaticString
    ) {
        var test = testName
        test.removeLast(2)
        self.testName = test
        self.file = file
    }
}
