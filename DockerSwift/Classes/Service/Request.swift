// Copyright 2019 Sysdata S.p.A.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import Alamofire

open class Request: NSObject {
    
    open var service: Service = Service()
    
    open var method: HTTPMethod = .get
    open var type: RequestType = .data
    
    open var headers: [String: String] = [:]
    open var urlParameterEncoding: URLEncoding = URLEncoding.queryString
    
    // HTTP Request
    internal var internalRequest: Alamofire.Request?
    public var urlRequest: URLRequest? {
        return internalRequest?.request
    }
    
    open var multipartBodyParts: [MultipartBodyPart]?
    
    // Error & Status Codes
    open var useDifferentResponseForErrors: Bool = false
    open var httpErrorStatusCodeRange: ClosedRange<Int> = 400...499
    
    //Demo mode
    open var useDemoMode: Bool = false
    open var demoSuccessFileName: String?
    open var demoFailureFileName: String?
    open var demoFilesBundle: Bundle = Bundle.main
    open var demoWaitingTimeRange: ClosedRange<TimeInterval> = 0.0...0.0
    open var demoSuccessStatusCode: Int = 200
    open var demoFailureStatusCode: Int = 400
    open var demoFailureChance: Double = 0.0
    internal var sentInDemoMode: Bool = false
    
    // Parameters
    open var pathParameters: [String: Any] = [:]
    open var urlParameters: [String: Any] = [:]
    open var bodyParameters: Encodable?
    
    // Build Request
    internal func buildUrlRequest() throws -> URLRequest {
        let url = try buildURL()
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        var allHeaders: [String:String] = service.sessionManager.session.configuration.httpAdditionalHeaders as! [String:String]
        allHeaders.merge(headers, uniquingKeysWith: { (_, last) -> String in last})
        request.allHTTPHeaderFields = allHeaders
        
        // body encoding
        if let bodyParams = bodyParameters {
            try encodeBody(request: &request, parameters: bodyParams)
        }
        
        // url encoding
        request = try request.encoded(parameters: urlParameters, parameterEncoding: urlParameterEncoding)
        
        return request
    }
    
    open func encodeBody(request: inout URLRequest, parameters: Encodable) throws {
        if let data = parameters as? Data {
            request.httpBody = data
        } else {
            throw DockerError.encoding(EncodingError.invalidValue(parameters, EncodingError.Context(codingPath: [], debugDescription: "")))
        }
    }
}

// MARK: Utils
extension Request {
    
    internal func buildURL() throws -> URL {
        var composedUrl = service.path.isEmpty ? service.baseUrl : service.baseUrl.appending(service.path)
        
        // search for "/:" to find the start of a path parameter
        while let paramRange = findNextPathParamPlaceholderRange(in: composedUrl) {
            let paramName = String(composedUrl[composedUrl.index(after: paramRange.lowerBound)..<paramRange.upperBound])
            let param = try findPathParam(with: paramName, in: pathParameters)
            composedUrl.replaceSubrange(paramRange, with: param)
        }
        guard let url = URL(string: composedUrl)
            else { throw DockerError.invalidURL(service) }
        return url
    }
    
    private func findNextPathParamPlaceholderRange(in string: String) -> Range<String.Index>? {
        if let startRange = string.range(of: "/:") {
            let semicolonIndex = string.index(after:startRange.lowerBound)
            let searchRange: Range<String.Index> = semicolonIndex..<string.endIndex
            if let endRange = string.range(of: "/", options: String.CompareOptions.caseInsensitive, range: searchRange, locale: nil) {
                return semicolonIndex..<endRange.lowerBound
            } else {
                return semicolonIndex..<string.endIndex
            }
        }
        return nil
    }
    
    private func findPathParam(with name:String, in parameters: [String:Any]) throws -> String {
        if let param = parameters[name] {
            return "\(param)"
        } else {
            throw DockerError.pathParameterNotFound(self, name)
        }
    }
}

open class RequestJSON: Request {
    
    public override init() {
        super.init()
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
    }
    
    open var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.secondsSince1970
        encoder.dataEncodingStrategy = JSONEncoder.DataEncodingStrategy.base64
        return encoder
    }
    
    open override func encodeBody(request: inout URLRequest, parameters: Encodable) throws {
        request = try request.encoded(encodable: parameters, encoder: jsonEncoder)
    }
}

open class RequestPList: Request {
    
    open var pListEncoder: PropertyListEncoder {
        let encoder = PropertyListEncoder()
        return encoder
    }
    
    open override func encodeBody(request: inout URLRequest, parameters: Encodable) throws {
        request = try request.encoded(encodable: parameters, encoder: pListEncoder)
    }
}

//MARK: CustomStringConvertible
extension Request {
    
    open override var description: String {
        var string = "REQUEST URL: \(service.baseUrl)\(service.path)\nMETHOD:\(method.rawValue)\nHEADERS:\(headers))"
        if !urlParameters.isEmpty {
            string.append("\nPARAMETERS:\(urlParameters)")
        }
        if let bodyParams = bodyParameters {
            string.append("\nBODY PARAMETERS:\(bodyParams)")
        }
        if let httpBody = urlRequest?.httpBody, let body = String(data: httpBody, encoding: .utf8) {
            string.append("\nBODY:\n\(body)")
        }
        return string
    }
    
    open var shortDescription: String {
        let string = "REQUEST \(method.rawValue) at \(urlStringDescription)"
        return string
    }
    
    open var urlStringDescription: String {
        if let url = urlRequest?.url?.absoluteString {
            return url
        }
        return service.path
    }
}
//MARK: Alamofire forwarding
extension Request {
    public func suspend() {
        internalRequest?.suspend()
    }
    
    public func resume() {
        internalRequest?.resume()
    }
    
    public func cancel() {
        internalRequest?.cancel()
    }
}

public struct MultipartBodyPart {
    var data: Data
    var name: String
    var fileName: String?
    var mimeType: String?
    
    public init(with data:Data, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
