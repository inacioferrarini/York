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

class BaseTableViewControllerTests: XCTestCase {
    
    
    // MARK: - Properties
    
    var viewController: BaseTableViewController!
    
    
    // MARK: - Tests Setup
    
    override func setUp() {
        super.setUp()
        let appContext = TestUtil().appContext()
        let navigationController = TestUtil().rootViewController()
        viewController = TestUtil().baseTableViewController(appContext)
        navigationController.pushViewController(viewController, animated: true)
        
        let _ = navigationController.view
        let _ = viewController.view
    }
    
    
    // MARK: - Tests
    
    func test_viewDidLoad_mustNotCrash() {
        self.viewController.viewDidLoad()
    }

    func test_viewDidAppear_mustNotCrash() {
        self.viewController.viewDidAppear(true)
    }
    
    
    func test_viewWillDisappear_mustNotCrash() {
        self.viewController.viewWillDisappear(true)
    }

    
    func test_defaultEmptyResultsBackgroundView_mustReturnNil() {
        XCTAssertNil(self.viewController.defaultEmptyResultsBackgroundView())
    }
    
    func test_defaultNonEmptyResultsBackgroundView_mustReturnNil() {
        XCTAssertNil(self.viewController.defaultNonEmptyResultsBackgroundView())
    }
    
    
    func test_setupTableView_mustNotCrash() {
        self.viewController.setupTableView()
    }

    
    func test_createDataSource_mustReturnNil() {
        XCTAssertNil(self.viewController.createDataSource())
    }
    
    
    func test_createDelegate_mustReturnNil() {
        XCTAssertNil(self.viewController.createDelegate())
    }
    
    
    func test_performDataSync_mustNotCrash() {
        self.viewController.performDataSync()
    }
    
    
    func test_dataSyncCompleted_mustNotCrash() {
        self.viewController.dataSyncCompleted()
    }
    
}
