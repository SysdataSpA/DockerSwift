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

internal extension URLRequest {
    
    mutating func encoded(encodable: Encodable, encoder: PropertyListEncoder) throws -> URLRequest {
        do {
            let encodable = EncodableWrapper(encodable)
            httpBody = try encoder.encode(encodable)
            
            let contentTypeHeaderName = "Content-Type"
            if value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                setValue("application/x-plist", forHTTPHeaderField: contentTypeHeaderName)
            }
            
            return self
        } catch {
            throw DockerError.encoding(error)
        }
    }
    
    mutating func encoded(encodable: Encodable, encoder: JSONEncoder) throws -> URLRequest {
        do {
            let encodable = EncodableWrapper(encodable)
            httpBody = try encoder.encode(encodable)
            
            let contentTypeHeaderName = "Content-Type"
            if value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                setValue("application/json; charset=UTF-8", forHTTPHeaderField: contentTypeHeaderName)
            }
            
            return self
        } catch {
            throw DockerError.encoding(error)
        }
    }
    
    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw DockerError.parameterEncoding(error)
        }
    }
}
