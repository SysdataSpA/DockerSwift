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

public typealias SessionManager = Alamofire.SessionManager
public typealias ServerTrustPolicy = Alamofire.ServerTrustPolicy
public typealias ServerTrustPolicyManager = Alamofire.ServerTrustPolicyManager
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias URLEncoding = Alamofire.URLEncoding
public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias Result<Value> = Alamofire.Result<Value>
public typealias RequestCompletion = (HTTPURLResponse?, URLRequest?, Data?, Swift.Error?) -> Void
public typealias ProgressHandler = Alamofire.Request.ProgressHandler
public typealias DownloadFileDestination = DownloadRequest.DownloadFileDestination
public typealias DownloadOptions = DownloadRequest.DownloadOptions

internal protocol Requestable {
    func response(callbackQueue: DispatchQueue?, completionHandler: @escaping RequestCompletion) -> Self
}

extension DataRequest: Requestable {
    internal func response(callbackQueue: DispatchQueue?, completionHandler: @escaping RequestCompletion) -> Self {
        return response(queue: callbackQueue) { handler  in
            _ = completionHandler(handler.response, handler.request, handler.data, handler.error)
        }
    }
}

extension DownloadRequest: Requestable {
    internal func response(callbackQueue: DispatchQueue?, completionHandler: @escaping RequestCompletion) -> Self {
        return response(queue: callbackQueue, completionHandler: { handler in
            _ = completionHandler(handler.response, handler.request, nil, handler.error)
        })
    }
}

extension Alamofire.HTTPMethod {
    /// A Boolean value determining whether the request supports multipart.
    public var supportsMultipart: Bool {
        switch self {
        case .post, .put, .patch, .connect:
            return true
        case .get, .delete, .head, .options, .trace:
            return false
        }
    }
}
