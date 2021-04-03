import Foundation

class FileManagerHandler {
    
    private let fileManager = FileManager.default
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init() {
        encoder.outputFormatting = .prettyPrinted
    }
    
    func store(diffableList: [Diffable]) throws {
        guard diffableList.count > 0 else { return }
        
        let identifier = diffableList.first!.identifier
        let storagePath = makeStoragePath(testName: identifier.testName, file: identifier.file)
        
        if !fileManager.fileExists(atPath: storagePath.path) {
            try? fileManager.createDirectory(at: storagePath, withIntermediateDirectories: true)
        }

        let newDocumentName = "\(identifier.testName).\(identifier.fileExtension)"
        let newDocumentPath = storagePath.appendingPathComponent(newDocumentName)
        
        
        do {
            let requests = diffableList.map { $0.request }
            let data = try encoder.encode(requests)
            try data.write(to: newDocumentPath)
        } catch {
            throw FileError.cantWrite(error: error, documentPath: newDocumentPath.absoluteString)
        }
    }
    
    func retrieve(identifier: RequestIdentifier) throws -> [Request]? {
        let storagePath = makeStoragePath(testName: identifier.testName, file: identifier.file)
        let targetDocumentName = "\(identifier.testName).\(identifier.fileExtension)"
        let targetDocumentPath = storagePath.appendingPathComponent(targetDocumentName)
        
        do {
            let data = try Data(contentsOf: targetDocumentPath)
            return try decoder.decode([Request].self, from: data)
        } catch {
            throw FileError.cantRead(error: error, documentPath: targetDocumentPath.absoluteString)
        }
    }
    
    private func makeStoragePath(testName: String, file: String) -> URL {
        let fileLocation = URL(fileURLWithPath: "\(file)", isDirectory: false)
        let fileName = fileLocation.deletingPathExtension().lastPathComponent

        return fileLocation.deletingLastPathComponent()
            .appendingPathComponent("RequestSnapshot")
            .appendingPathComponent(fileName)
    }
}
