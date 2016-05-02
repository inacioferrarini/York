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

class ViewComponentTests: XCTestCase {


    // MARK: - Tests

    func test_initWithFrameWithBundle_mustSucceed() {
        let testsBundle = TestUtil().unitTestsBundle()
        let view = SimpleViewComponent(frame: CGRect(x: 0, y: 0, width: 100, height: 100), bundle: testsBundle)
        XCTAssertNotNil(view)
    }

    func test_initWithFrameWithoutBundle_mustSucceed() {
        let testsBundle:NSBundle? = nil
        let view = SimpleViewComponent(frame: CGRect(x: 0, y: 0, width: 100, height: 100), bundle: testsBundle)
        XCTAssertNotNil(view)
    }

    func test_initWithCoder_mustSucceed() {
        let testsBundle = TestUtil().unitTestsBundle()
        let view = SimpleViewComponent(frame: CGRect(x: 0, y: 0, width: 100, height: 100), bundle: testsBundle)
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(view)
        let decoder = NSKeyedUnarchiver(forReadingWithData: encodedData)
        let viewDecoded = SimpleViewComponent(coder: decoder)
        XCTAssertNotNil(viewDecoded)
    }

}
