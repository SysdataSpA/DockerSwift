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

import UIKit
import Alamofire

/// Represents an HTTP task.
public enum RequestType {
    
    /// A request to send or receive data
    case data
    
    /// A file upload task.
    case upload(RequestType.UploadType)
    
    /// A file download task to a destination.
    case download(DownloadFileDestination)
    
    public enum UploadType {
        /// A file upload task.
        case file(URL)
        
        /// A "multipart/form-data" upload task.
        case multipart
    }
}

public protocol ServiceProtocol {
    var sessionManager: SessionManager { get }
    var path: String { get }
    var baseUrl: String { get }
}

open class Service: ServiceProtocol {
    open var path: String
    open var baseUrl: String
    open var sessionManager: SessionManager {
        return SessionManager.default
    }
    
    public required init() {
        self.path = ""
        self.baseUrl = ""
    }
}
