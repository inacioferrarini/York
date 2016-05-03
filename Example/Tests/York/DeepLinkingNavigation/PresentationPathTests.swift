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

class PresentationPathTests: XCTestCase {


    // MARK: - Tests

    func test_absoluteString_mustReturnPresentationParameter() {
        let presentationPath = PresentationPath(pattern: "/path/to/viewcontroller")
        let stringPath = presentationPath.absoluteString()
        XCTAssertEqual(stringPath, "/path/to/viewcontroller/:presentation")
    }

    func test_absoluteStringEndingSlash_mustReturnPresentationParameter() {
        let presentationPath = PresentationPath(pattern: "/path/to/viewcontroller/")
        let stringPath = presentationPath.absoluteString()
        XCTAssertEqual(stringPath, "/path/to/viewcontroller/:presentation")
    }


    // MARK: - Tests - PresentationMode

    func test_presentationModeForPath_withoutPresentationMode_mustReturnPush() {
        let presentationMode = PresentationPath.presentationMode(["" : ""])
        XCTAssertEqual(presentationMode, PresentationMode.Push)
    }

    func test_presentationModeForPath_withPushPresentationMode_mustReturnPush() {
        let presentationMode = PresentationPath.presentationMode([":presentation" : "push"])
        XCTAssertEqual(presentationMode, PresentationMode.Push)
    }

    func test_presentationModeForPath_withShowPresentationMode_mustReturnShow() {
        let presentationMode = PresentationPath.presentationMode([":presentation" : "show"])
        XCTAssertEqual(presentationMode, PresentationMode.Show)
    }

    func test_presentationModeForPath_withModalPresentationMode_mustReturnModal() {
        let presentationMode = PresentationPath.presentationMode([":presentation" : "modal"])
        XCTAssertEqual(presentationMode, PresentationMode.Modal)
    }

    func test_presentationModeForPath_withPopoverPresentationMode_mustReturnPopover() {
        let presentationMode = PresentationPath.presentationMode([":presentation" : "popover"])
        XCTAssertEqual(presentationMode, PresentationMode.Popover)
    }


    // MARK: - Tests - PresentationMode

    func test_pathWithValuesAndPresentationMode_mustSucceed() {
        let presentationPath = PresentationPath(pattern: "/:param1/:param2/:param3/")
        let values = [ ":param1": "valueForParam1", ":param2": "valueForParam2", ":param3": "valueForParam3" ]
        let finalUrl = presentationPath.replacingValues(values, mode: .Push)
        XCTAssertEqual(finalUrl, "/valueForParam1/valueForParam2/valueForParam3/push")
    }

}
