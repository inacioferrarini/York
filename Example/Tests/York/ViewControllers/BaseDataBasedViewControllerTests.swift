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

class BaseDataBasedViewControllerTests: XCTestCase {


    // MARK: - Properties

    var viewController: BaseDataBasedViewController!


    // MARK: - Tests Setup

    override func setUp() {
        super.setUp()
        let appContext = TestUtil().appContext()
        let navigationController = TestUtil().rootViewController()
        viewController = TestUtil().testBaseDataBasedViewController(appContext)
        navigationController.pushViewController(viewController, animated: true)

        _ = navigationController.view
        _ = viewController.view
    }


    // MARK: - Tests

    func test_viewDidAppear() {
        self.viewController.viewDidAppear(true)
    }


    func test_shouldSyncData_mustReturnsFalse() {
        XCTAssertTrue(self.viewController.shouldSyncData())
    }


    func test_perforDataSync() {
        self.viewController.performDataSync()
    }


    func test_showCourtainView_withoutCourtain() {
        self.viewController.showCourtainView()
    }

    func test_showCourtainView_withCourtain() {
        self.viewController.showCourtainView()
    }


    func test_hideCourtainView_withoutCourtain() {
        self.viewController.hideCourtainView()
    }

    func test_hideCourtainView_withCourtain() {
        self.viewController.hideCourtainView()
    }


//    func test_performDataSyncIfNeeded() {
//        self.viewController.performDataSyncIfNeeded()
//    }

}
