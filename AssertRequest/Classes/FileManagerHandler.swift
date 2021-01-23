import Foundation

class FileManagerHandler {
    
    private let fileManager = FileManager.default
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init() {
        encoder.outputFormatting = .prettyPrinted
    }
    
    func store(request: Request, identifier: RequestIdentifier) {
        let storagePath = makeStoragePath(testName: identifier.testName, file: identifier.file)
        
        if !fileManager.fileExists(atPath: storagePath.path) {
            try? fileManager.createDirectory(at: storagePath, withIntermediateDirectories: true)
        }

        let newDocumentName = "\(identifier.testName).\(identifier.fileExtension)"
        let newDocumentPath = storagePath.appendingPathComponent(newDocumentName)
        
        
        do {
            
            let data = try encoder.encode(request)
            try data.write(to: newDocumentPath)
        } catch {
            //todo: handle this error
            print(error.localizedDescription)
        }
    }
    
    func retrieve(identifier: RequestIdentifier) -> Request? {
        let storagePath = makeStoragePath(testName: identifier.testName, file: identifier.file)
        let targetDocumentName = "\(identifier.testName).\(identifier.fileExtension)"
        let targetDocumentPath = storagePath.appendingPathComponent(targetDocumentName)
        
        do {
            let data = try Data(contentsOf: targetDocumentPath)
            return try decoder.decode(Request.self, from: data)
        } catch {
            //todo: handle this error
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func makeStoragePath(testName: String, file: StaticString) -> URL {
        let fileLocation = URL(fileURLWithPath: "\(file)", isDirectory: false)
        let fileName = fileLocation.deletingPathExtension().lastPathComponent

        return fileLocation.deletingLastPathComponent()
            .appendingPathComponent("RequestSnapshot")
            .appendingPathComponent(fileName)
    }
}
