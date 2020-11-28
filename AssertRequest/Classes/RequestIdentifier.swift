struct RequestIdentifier {
    let testName: StaticString
    let file: StaticString
    let fileExtension: String
    
    init(
        testName: StaticString = #function,
        file: StaticString = #file,
        fileExtension: String = "curl"
    ) {
        self.testName = testName
        self.file = file
        self.fileExtension = fileExtension
    }
}
