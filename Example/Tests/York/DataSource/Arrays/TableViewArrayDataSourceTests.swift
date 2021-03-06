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

class TableViewArrayDataSourceTests: XCTestCase {


    // MARK: - Properties

    var tableView: UITableView!
    var presenter: TableViewCellPresenter<UITableViewCell, NSNumber>!
    var configureCellBlockWasCalled: Bool = false


    // MARK: - Supporting Methods

    func createTableViewArrayDataSource() -> TableViewArrayDataSource<UITableViewCell, NSNumber> {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let tableView = TestsTableView(frame: frame)
        tableView.cellForRowAtIndexPathBlock = { (indexPath: IndexPath) -> UITableViewCell? in
            return UITableViewCell()
        }
        self.registerCellForTableView(tableView)
        self.tableView = tableView
        
        let cellReuseIdBlock: ((_ indexPath: IndexPath) -> String) = { (indexPath: IndexPath) -> String in
            return "TableViewCell"
        }
        self.presenter = TableViewCellPresenter<UITableViewCell, NSNumber>(
            configureCellBlock: { (cell: UITableViewCell, entity: NSNumber) -> Void in
                self.configureCellBlockWasCalled = true
            }, cellReuseIdentifierBlock: cellReuseIdBlock)
        
        let dataSource = TableViewArrayDataSource<UITableViewCell, NSNumber>(
            targetingTableView: self.tableView,
            presenter: self.presenter,
            objects: [10, 20, 30, 40])
        self.tableView.dataSource = dataSource
        return dataSource
    }
    
    func registerCellForTableView(_ tableView: UITableView) {
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: TestUtil().unitTestsBundle())
        tableView.register(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
    }


    // MARK: - Tests - refresh

    func test_refresh_mustSucceed() {
        let dataSource = self.createTableViewArrayDataSource()
        dataSource.refreshData()
    }


    // MARK: - Tests - numberOfSections

    func test_numberOfSections_mustReturnOne() {
        let dataSource = self.createTableViewArrayDataSource()
        let numberOfSections = dataSource.numberOfSections(in: self.tableView)
        XCTAssertEqual(numberOfSections, 1)
    }


    // MARK: - Tests - numberOfItemsInSection

    func test_numberOfItemsInSection_mustReturnZero() {
        let dataSource = self.createTableViewArrayDataSource()
        let numberOfItems = dataSource.tableView(self.tableView, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfItems, 0)
    }

    func test_numberOfItemsInSection_mustReturnFour() {
        let dataSource = self.createTableViewArrayDataSource()
        let numberOfItems = dataSource.tableView(self.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfItems, 4)
    }


    // MARK: - Tests - cellForItemAtIndexPath

    func test_cellForRowAtIndexPath_mustReturnCell() {
        let dataSource = self.createTableViewArrayDataSource()
        let indexPath = IndexPath(item: 0, section: 0)
        _ = dataSource.tableView(self.tableView, cellForRowAt: indexPath)
        XCTAssertTrue(self.configureCellBlockWasCalled)
    }


    // MARK: - Tests - canEditRowAtIndexPath

    func test_canEditRowAtIndexPath_withBlock_mustReturnTrue() {
        let dataSource = self.createTableViewArrayDataSource()
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: IndexPath) -> Bool in
            return true
        }
        let indexPath = IndexPath(item: 0, section: 0)
        XCTAssertTrue(dataSource.tableView(self.tableView, canEditRowAt: indexPath))
    }

    func test_canEditRowAtIndexPath_withoutBlock_mustReturnFalse() {
        let dataSource = self.createTableViewArrayDataSource()
        dataSource.presenter.canEditRowAtIndexPathBlock = nil
        let indexPath = IndexPath(item: 0, section: 0)
        XCTAssertFalse(dataSource.tableView(self.tableView, canEditRowAt: indexPath))
    }


    // MARK: - Tests - commitEditingStyle

    func test_commitEditingStyle_withBlock_mustReturnTrue() {
        var blockWasCalled: Bool = false
        let dataSource = self.createTableViewArrayDataSource()
        dataSource.presenter.commitEditingStyleBlock = { (editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath: IndexPath) -> Void in
            blockWasCalled = true
        }
        let indexPath = IndexPath(item: 0, section: 0)
        dataSource.tableView(self.tableView, commit: .none, forRowAt: indexPath)
        XCTAssertTrue(blockWasCalled)
    }

    func test_commitEditingStyle_withoutBlock_mustReturnFalse() {
        let dataSource = self.createTableViewArrayDataSource()
        dataSource.presenter.commitEditingStyleBlock = nil
        let indexPath = IndexPath(item: 0, section: 0)
        dataSource.tableView(self.tableView, commit: .none, forRowAt: indexPath)
    }

}
