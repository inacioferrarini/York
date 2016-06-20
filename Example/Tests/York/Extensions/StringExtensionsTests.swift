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

import XCTest
import York

class StringExtensionsTests: XCTestCase {


    // MARK: - Tests

    func test_isNumber_onlyNumber_mustReturnTrue() {
        let string = "40"
        XCTAssertTrue(string.isNumber())
    }

    func test_isNumber_stringWithSpace_mustReturnFalse() {
        let string = "40 "
        XCTAssertFalse(string.isNumber())
    }

    func test_isNumber_stringWithChar_mustReturnFalse() {
        let string = "40x"
        XCTAssertFalse(string.isNumber())
    }

    func test_replaceStrings_mustNotCrash() {
        let baseString = "111.111.111-11"
        let replacedString = baseString.replaceStrings(pairing: ["." : "x", "-" : "y"])
        let compareString = "111x111x111y11"
        XCTAssertEqual(replacedString, compareString)
    }

    func test_removeStrings_mustNotCrash() {
        let baseString = "111.111.111-11"
        let replacedString = baseString.removeStrings([".", "-"])
        let compareString = "11111111111"
        XCTAssertEqual(replacedString, compareString)
    }

}
