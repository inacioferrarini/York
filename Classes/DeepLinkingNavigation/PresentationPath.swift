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

open class PresentationPath: NSObject {


    // MARK: - Constants

    open let presentationParameterPath = "/:presentation"
    open static let presentationParameterPathKey = "presentation"


    // MARK: - Properties

    open fileprivate (set) var pattern: String


    // MARK: - Class Methods

    open class func presentationMode(_ parameters: [AnyHashable: Any]) -> PresentationMode {
        var mode: PresentationMode = .Push
        if let presentationModeValue = parameters[presentationParameterPathKey] as? String,
            let value = PresentationMode(rawValue: presentationModeValue) {
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

    open func absoluteString() -> String {
        return self.removeLastPathSeparator(self.pattern) + self.presentationParameterPath
    }

    open func replacingValues(_ mode: PresentationMode) -> String {
        return self.replacingValues(nil, mode: mode)
    }

    open func replacingValues(_ values: [String : String]?, mode: PresentationMode) -> String {
        var replacedValuesPath = self.removeLastPathSeparator(self.pattern)
        if let values = values {
            for (key, value) in values {
                let range = replacedValuesPath.range(of: key)
                replacedValuesPath = replacedValuesPath.replacingOccurrences(of: key, with: value, options: .caseInsensitive, range: range)
            }
        }
        return self.removeLastPathSeparator(replacedValuesPath) + "/" + mode.rawValue
    }

    open func removeLastPathSeparator(_ path: String) -> String {
        var cleanPath = path
        let lastIndex = path.characters.index(before: path.endIndex)

        if lastIndex > path.startIndex {
            let lastChar = path[lastIndex]
            if lastChar == "/" {
                cleanPath = path.substring(to: lastIndex)
            }
        }
        return cleanPath
    }

}
