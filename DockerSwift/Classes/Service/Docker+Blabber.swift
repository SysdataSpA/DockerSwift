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

let DockerServiceLogModuleName = "Docker.Service"

#if BLABBER
import Blabber
public func SDLogModuleError(_ message: @autoclosure () -> String, module: String, file: StaticString = #file , function: StaticString = #function, line: UInt = #line)
{
    SDLogger.shared().log(with: .error, module: module,  file: String(describing: file), function: String(describing: function), line: line, message: message())
}
public func SDLogModuleInfo(_ message: @autoclosure () -> String, module: String,file: StaticString = #file , function: StaticString = #function, line: UInt = #line)
{
    SDLogger.shared().log(with: .info, module: module,  file: String(describing: file), function: String(describing: function), line: line, message: message())
}
public func SDLogModuleWarning(_ message: @autoclosure () -> String, module: String,file: StaticString = #file , function: StaticString = #function, line: UInt = #line)
{
    SDLogger.shared().log(with: .warning, module: module,  file: String(describing: file), function: String(describing: function), line: line, message: message())
}
public func SDLogModuleVerbose(_ message: @autoclosure () -> String, module: String,file: StaticString = #file , function: StaticString = #function, line: UInt = #line)
{
    SDLogger.shared().log(with: .verbose, module: module,  file: String(describing: file), function: String(describing: function), line: line, message: message())
}
#else
public func SDLogError(_ message: @autoclosure () -> String, file: StaticString = #file , function: StaticString = #function, line: UInt = #line)
{
    print(message())
}
public func SDLogInfo(_ message: @autoclosure () -> String, file: StaticString = #file , function: StaticString = #function, line: UInt = #line)
{
    print(message())
}
public func SDLogWarning(_ message: @autoclosure () -> String, file: StaticString = #file , function: StaticString = #function, line: UInt = #line)
{
    print(message())
}
public func SDLogVerbose(_ message: @autoclosure () -> String, file: StaticString = #file , function: StaticString = #function, line: UInt = #line)
{
    print(message())
}
#endif
