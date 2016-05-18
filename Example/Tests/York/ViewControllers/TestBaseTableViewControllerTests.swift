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

class TestBaseTableViewControllerTests: XCTestCase {

//
//    // MARK: - Properties
//
//    var viewController: TestBaseTableViewController!
//
//
//    // MARK: - Tests Setup
//
//    override func setUp() {
//        super.setUp()
//        let appContext = TestUtil().testAppContext()
//        let navigationController = TestUtil().rootViewController()
//        viewController = TestUtil().testBaseTableViewController(appContext)
//        navigationController.pushViewController(viewController, animated: true)
//
//        let _ = navigationController.view
//        let _ = viewController.view
//    }
//
//
//    // MARK: - Tests
//
//    func test_viewDidLoad_mustNotCrash() {
//        self.viewController.viewDidLoad()
//    }
//
//
//    func test_viewWillDisappear_mustNotCrash() {
//        self.viewController.viewDidLoad()
//        let context = self.viewController.appContext.coreDataStack.managedObjectContext
//
//        let helper = CoreDataUtil(inManagedObjectContext: context)
//        helper.removeAllTestEntities()
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
//
//        if let dataSource = self.viewController.dataSource as? TableViewFetcherDataSource<UITableViewCell, EntityTest> {
//            dataSource.refreshData()
//        }
//
//        self.viewController.tableView!.reloadData()
//
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.viewController.tableView!.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Top)
//
//        self.viewController.viewWillDisappear(true)
//    }
//
//
//    func test_createDataSource_mustReturnNotNil() {
//        XCTAssertNotNil(self.viewController.createDataSource())
//    }
//
//    func test_dataSource_checkPresenterConfigureCellBlock() {
//        self.viewController.viewDidLoad()
//        let coreDataStack = TestUtil().testAppContext().coreDataStack
//        let ctx = coreDataStack.managedObjectContext
//        let helper = CoreDataUtil(inManagedObjectContext: ctx)
//        let entity = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).first!
//        let cell = UITableViewCell()
//        if let dataSource = self.viewController.dataSource as? TableViewFetcherDataSource<UITableViewCell, EntityTest> {
//            dataSource.presenter.configureCellBlock(cell, entity)
//        }
//    }
//
//
//    func test_createDelegate_mustReturnNotNil() {
//        XCTAssertNotNil(self.viewController.createDelegate())
//    }
//
//    func test_delegate_checkItemSelectionBlock() {
//        self.viewController.viewDidLoad()
//        if let delegate = self.viewController.delegate as? TableViewBlockDelegate {
//            delegate.itemSelectionBlock(indexPath: NSIndexPath(forRow: 0, inSection: 0))
//        }
//    }
//
//
//    func test_dataSyncCompleted_mustNotCrash() {
//        self.viewController.dataSyncCompleted()
//    }

}
