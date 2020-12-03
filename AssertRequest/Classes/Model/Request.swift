import Foundation

struct Request: Codable {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: String?
    
    init(urlRequest: URLRequest, bodyEncoding: String.Encoding = .utf8) throws {
        guard let urlAbsoluteString = urlRequest.url?.absoluteString else {
            throw HTTPRequestParsingError.noURL
        }
        url = urlAbsoluteString
        
        guard let httpMethodString = urlRequest.httpMethod,
              let httpMethod = HTTPMethod(rawValue: httpMethodString) else {
            throw HTTPRequestParsingError.noURL
        }
        method = httpMethod
        
        headers = urlRequest.allHTTPHeaderFields
        
        if let bodyData = urlRequest.httpBody {
            body = String(data: bodyData, encoding: bodyEncoding)
        } else {
            body = nil
        }
    }
}

extension Request: Equatable {
    
}
