import Foundation

class FileManagerHandler {
    
    private let fileManager = FileManager.default
    
    func store(data: Data, identifier: RequestIdentifier) {
        let storagePath = makeStoragePath(testName: identifier.testName, file: identifier.file)
        
        if !fileManager.fileExists(atPath: storagePath.path) {
            try? fileManager.createDirectory(at: storagePath, withIntermediateDirectories: true)
        }

        let newDocumentName = "\(identifier.testName).\(identifier.fileExtension)"
        let newDocumentPath = storagePath.appendingPathComponent(newDocumentName)

        do {
            try data.write(to: newDocumentPath)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieve(identifier: RequestIdentifier) -> Data? {
        let storagePath = makeStoragePath(testName: identifier.testName, file: identifier.file)
        let targetDocumentName = "\(identifier.testName).\(identifier.fileExtension)"
        let targetDocumentPath = storagePath.appendingPathComponent(targetDocumentName)
        
        do {
            return try Data(contentsOf: targetDocumentPath)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func makeStoragePath(testName: StaticString, file: StaticString) -> URL {
        let fileLocation = URL(fileURLWithPath: "\(file)", isDirectory: false)
        let fileName = fileLocation.deletingPathExtension().lastPathComponent

        return fileLocation.deletingLastPathComponent()
            .appendingPathComponent("RequestSnapshot")
            .appendingPathComponent(fileName)
    }
}
