//    The MIT License (MIT)
//
//    Copyright (c) 2016 Inácio Ferrarini
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import UIKit

public enum PresentationPathMode: String {
    case Push = "push"
    case Show = "show"
    case Modal = "modal"
    case Popover = "popover"
}

public class PresentationPath: NSObject {


    // MARK: - Constants

    public let presentationParameterPath = "/:presentation"
    public static let presentationParameterPathKey = ":presentation"

    // MARK: - Properties

    public private (set) var pattern: String


    // MARK: - Class Methods

    public class func presentationMode(parameters: [NSObject : AnyObject]) -> PresentationPathMode {
        var mode: PresentationPathMode = .Push
        if let presentationModeValue = parameters[presentationParameterPathKey] as? String,
            let value = PresentationPathMode(rawValue: presentationModeValue) {
            mode = value
        }
        return mode
    }


    // MARK: - Initialization

    public init(pattern: String) {
        self.pattern = pattern
        super.init()
    }


    // MARK: - Public Methods

    public func absoluteString() -> String {
        return self.removeLastPathSeparator(self.pattern) + self.presentationParameterPath
    }

    public func replacingValues(values: [String : String], mode: PresentationPathMode) -> String {
        var path = self.removeLastPathSeparator(self.pattern)

        for (key, value) in values {
            let range = path.rangeOfString(key)
            path = path.stringByReplacingOccurrencesOfString(key, withString: value, options: .CaseInsensitiveSearch, range: range)
        }

        return self.removeLastPathSeparator(path) + "/" + mode.rawValue
    }

    private func removeLastPathSeparator(path: String) -> String {
        var cleanPath = path
        let lastIndex = path.endIndex.predecessor()

        if lastIndex > path.startIndex {
            let lastChar = path[lastIndex]
            if lastChar == "/" {
                cleanPath = path.substringToIndex(lastIndex)
            }
        }
        return cleanPath
    }

}
