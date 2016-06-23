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

class TableViewArrayOfArrayDataSourceTests: XCTestCase {
    
    
    // MARK: - Properties
    
    var tableView: UITableView!
    var presenter: TableViewCellPresenter<UITableViewCell, NSNumber>!
    var configureCellBlockWasCalled: Bool = false
    
    
    // MARK: - Supporting Methods
    
    func createTableViewArrayOfArrayDataSource() -> TableViewArrayOfArrayDataSource<UITableViewCell, NSNumber> {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let tableView = TestsTableView(frame: frame)
        tableView.cellForRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> UITableViewCell? in
            return UITableViewCell()
        }
        self.registerCellForTableView(tableView)
        self.tableView = tableView
        
        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return "TableViewCell"
        }
        self.presenter = TableViewCellPresenter<UITableViewCell, NSNumber>(
            configureCellBlock: { (cell: UITableViewCell, entity: NSNumber) -> Void in
                self.configureCellBlockWasCalled = true
            }, cellReuseIdentifierBlock: cellReuseIdBlock)
        
        let dataSource = TableViewArrayOfArrayDataSource<UITableViewCell, NSNumber>(
            targetingTableView: self.tableView,
            presenter: self.presenter,
            objects: [[10], [10, 20], [10, 20, 30, 40]])
        self.tableView.dataSource = dataSource
        return dataSource
    }
    
    func registerCellForTableView(tableView: UITableView) {
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: TestUtil().unitTestsBundle())
        tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
    }
    
    
    // MARK: - Tests - refresh
    
    func test_refresh_mustSucceed() {
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        dataSource.refreshData()
    }


    // MARK: - Tests - numberOfSections

    func test_numberOfSections_mustReturnOne() {
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        let numberOfSections = dataSource.numberOfSectionsInTableView(self.tableView)
        XCTAssertEqual(numberOfSections, 3)
    }


    // MARK: - Tests - numberOfItemsInSection

    func test_numberOfItemsInSection_mustReturnZero() {
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        let numberOfItems = dataSource.tableView(self.tableView, numberOfRowsInSection: 3)
        XCTAssertEqual(numberOfItems, 0)
    }

    func test_numberOfItemsInSection_mustReturnFour() {
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        let numberOfItems = dataSource.tableView(self.tableView, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfItems, 2)
    }


    // MARK: - Tests - cellForItemAtIndexPath

    func test_cellForRowAtIndexPath_mustReturnCell() {
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        dataSource.tableView(self.tableView, cellForRowAtIndexPath: indexPath)
        XCTAssertTrue(self.configureCellBlockWasCalled)
    }


    // MARK: - Tests - canEditRowAtIndexPath

    func test_canEditRowAtIndexPath_withBlock_mustReturnTrue() {
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> Bool in
            return true
        }
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        XCTAssertTrue(dataSource.tableView(self.tableView, canEditRowAtIndexPath: indexPath))
    }

    func test_canEditRowAtIndexPath_withoutBlock_mustReturnFalse() {
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        dataSource.presenter.canEditRowAtIndexPathBlock = nil
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        XCTAssertFalse(dataSource.tableView(self.tableView, canEditRowAtIndexPath: indexPath))
    }


    // MARK: - Tests - commitEditingStyle

    func test_commitEditingStyle_withBlock_mustReturnTrue() {
        var blockWasCalled: Bool = false
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        dataSource.presenter.commitEditingStyleBlock = { (editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath: NSIndexPath) -> Void in
            blockWasCalled = true
        }
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        dataSource.tableView(self.tableView, commitEditingStyle: .None, forRowAtIndexPath: indexPath)
        XCTAssertTrue(blockWasCalled)
    }

    func test_commitEditingStyle_withoutBlock_mustReturnFalse() {
        let dataSource = self.createTableViewArrayOfArrayDataSource()
        dataSource.presenter.commitEditingStyleBlock = nil
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        dataSource.tableView(self.tableView, commitEditingStyle: .None, forRowAtIndexPath: indexPath)
    }

}
