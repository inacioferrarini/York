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

import Foundation

public extension String {

    public func isNumber() -> Bool {
        let badCharacters = CharacterSet.decimalDigits.inverted
        return self.rangeOfCharacter(from: badCharacters) == nil
    }

    public func replaceString(inRange range: NSRange, withString string: String) -> String {
//        let startIndex = self.characters.index(self.startIndex, offsetBy: range.location)
//        let endIndex =     <#T##String.CharacterView corresponding to `startIndex`##String.CharacterView#>.index(startIndex, offsetBy: range.length)
//        let stringReplaceRange = startIndex..<endIndex
//        return self.replacingCharacters(in: stringReplaceRange, with: string)
        return "Recheck this function :("
    }

    public func replaceStrings(pairing strings: [String : String]) -> String {
        var string = self
        for (key, value) in strings {
            string = string.replacingOccurrences(of: key, with: value)
        }
        return string
    }

    public func removeStrings(_ strings: [String]) -> String {
        let pairDictionary = strings.reduce([String : String]()) { (currentPairDictionary: [String : String], currentString: String) -> [String : String] in
            var updatedCurrentPairDictionary = currentPairDictionary
            updatedCurrentPairDictionary[currentString] = ""
            return updatedCurrentPairDictionary
        }
        return self.replaceStrings(pairing: pairDictionary)
    }

}
