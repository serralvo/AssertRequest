struct RequestIdentifier {
    let testName: StaticString
    let file: StaticString
    let fileExtension: String
    
    init(
        testName: StaticString = #function,
        file: StaticString = #file,
        fileExtension: String = "json"
    ) {
        self.testName = testName
        self.file = file
        self.fileExtension = fileExtension
    }
}
