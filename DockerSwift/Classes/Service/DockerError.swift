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

public enum DockerError: Error {
    
    case generic(Swift.Error?)
    
    /// Indicates an invalid URL
    case invalidURL(Service)
    
    /// Indicates that Encodable couldn't be encoded into Data
    case encoding(Swift.Error)
    
    /// Indicates that a `Request` failed to encode the parameters for the `URLRequest`.
    case parameterEncoding(Swift.Error)
    
    /// Indicates a response failed due to an underlying `Error`.
    case underlying(Swift.Error, HTTPURLResponse?, Int)
    
    /// Indicates a missing response and the corresponding URLErrorDomainCode.
    case missingResponse(Swift.Error, Int)
    
    /// Indicates that the demo file in case of succeess is nil
    case nilSuccessDemoFile()
    
    /// Indicates that the demo file in case of failure is nil
    case nilFailureDemoFile()
    
    /// Indicates that the demo file does not exist
    case demoFileNotFound(String)
    
    /// Indicates that the request's method does not support multipart
    case multipartNotSupported(HTTPMethod)
    
    /// A multipart request does not contain any body part
    case emptyMultipartBody()
    
    /// Indicates that a path parameter was not found in request's parameters
    case pathParameterNotFound(Request, String)
    
    /// Indicates that Decodable couldn't be decoded from data
    case decoding(Swift.Error?)
}

extension DockerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .generic: return "An error occured in service"
        case .invalidURL(let service): return "The URL of the service is invalid.\n\tBase URL: \(service.baseUrl ?? "unknown")\n\tPath: \(service.path ?? "unknown")"
        case .encoding: return "Failed to encode Encodable object into data."
        case .parameterEncoding(let error): return "Failed to encode parameters for URLRequest. \(error.localizedDescription)"
        case .underlying(let error, _, _): return error.localizedDescription
        case .missingResponse(let error, let errorCode): return "Missing response for connection Error. \(error.localizedDescription)"
        case .nilSuccessDemoFile: return "The success demo file is nil"
        case .nilFailureDemoFile: return "The failure demo file is nil"
        case .demoFileNotFound(let filename): return "The demo file \(filename) does not exist"
        case .multipartNotSupported(let method): return "The \(method.rawValue) does not support multipart"
        case .emptyMultipartBody: return "The multipart request's body is empty"
        case .pathParameterNotFound(let request, let paramName): return "Path parameter \"\(paramName)\" not found in \(String(describing: type(of: request))) parameters"
        case .decoding: return "Failed to decode object from data."
        }
    }
}
