DockerSwift
======

[![Version](https://img.shields.io/cocoapods/v/DockerSwift.svg?style=flat)](http://cocoapods.org/pods/DockerSwift)
[![License](https://img.shields.io/cocoapods/l/DockerSwift.svg?style=flat)](http://cocoapods.org/pods/DockerSwift)
[![Platform](https://img.shields.io/cocoapods/p/DockerSwift.svg?style=flat)](http://cocoapods.org/pods/DockerSwift)

![](https://github.com/SysdataSpA/DockerSwift/blob/develop/docker_example.gif)

DockerSwift is a library that could be used to manage all communications with remote
servers in an easy way.

Example
-------

To run the example project, clone the repo, and run `pod install` from the
Example directory first.

Requirements
------------

iOS 9 and above, Alamofire 4 (as pod dependency)

Installation
------------

DockerSwift is available through [CocoaPods](http://cocoapods.org). To install it,
simply add the following line to your Podfile:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ruby
pod 'DockerSwift'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to use our logger framework Blabber, use subpod

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pod 'DockerSwift/Blabber'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

With Blabber you can manage all log messages or use CocoaLumberjack. In this
case import also the corresponding subpod. [See
more](https://github.com/SysdataSpA/Blabber) details...

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pod 'DockerSwift/Blabber'
pod 'Blabber/CocoaLumberjack'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

License
-------

DockerSwift is available under the Apache license. See the LICENSE file for more
info.
