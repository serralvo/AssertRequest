struct RequestIdentifier {
    let testName: StaticString
    let file: StaticString
    let fileExtension: String
    
    init(
        testName: StaticString,
        file: StaticString,
        fileExtension: String
    ) {
        self.testName = testName
        self.file = file
        self.fileExtension = fileExtension
    }
}
