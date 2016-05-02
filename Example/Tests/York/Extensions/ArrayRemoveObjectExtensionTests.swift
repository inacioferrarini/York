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

class ArrayRemoveObjectExtensionTests: XCTestCase {


    // MARK: - Tests

    func test_removeObject_existingObject_mustSucceed() {
        var strings: [String] = ["A", "B", "C"]
        strings.removeObject("B")
        XCTAssertEqual(strings, ["A", "C"])
    }

    func test_removeObject_nonExistingObject_mustSucceed() {
        var strings: [String] = ["A", "B", "C"]
        strings.removeObject("D")
        XCTAssertEqual(strings, ["A", "B", "C"])
    }

    func test_removeObjectsInArray_existingObject_mustSucceed() {
        var strings: [String] = ["A", "B", "C"]
        strings.removeObjectsInArray(["A", "B"])
        XCTAssertEqual(strings, ["C"])
    }

    func test_removeObjectsInArray_nonExistingObject_mustSucceed() {
        var strings: [String] = ["A", "B", "C"]
        strings.removeObjectsInArray(["D", "E"])
        XCTAssertEqual(strings, ["A", "B", "C"])
    }

}
