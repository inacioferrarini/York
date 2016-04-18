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
import CoreData
import York

class TableViewCellPresenterTests: XCTestCase {
    
    static let modelFileName = "DataSyncRules"
    static let databaseFileName = "DataSyncHourlyRulesTests"
    
    static let cellReuseId = "ReuseCellID"
    static var blockExecutionTest = ""
    
    func createTableViewCellPresenter() -> TableViewCellPresenter<UITableViewCell, EntitySyncHistory> {
        let presenter = TableViewCellPresenter<UITableViewCell, EntitySyncHistory>(
            configureCellBlock: { (cell: UITableViewCell, entity:EntitySyncHistory) -> Void in
                TableViewCellPresenterTests.blockExecutionTest = "testExecuted"
            }, cellReuseIdentifier: TableViewCellPresenterTests.cellReuseId)
        return presenter
    }
    
    func test_tableViewCellPresenterFields_configureCellBlock() {
        let yorkBundle = TestUtil().yorkPODBundle()
        let logger = Logger()
        let dataSyncRulesStack = CoreDataStack(modelFileName: TableViewCellPresenterTests.modelFileName, databaseFileName: TableViewCellPresenterTests.databaseFileName, logger: logger,
            bundle: yorkBundle)
        let presenter = self.createTableViewCellPresenter()
        let cell = UITableViewCell()
        let ctx = dataSyncRulesStack.managedObjectContext
        let obj = EntitySyncHistory.entityAutoSyncHistoryByName("xpto", lastExecutionDate: nil, inManagedObjectContext: ctx)!
        presenter.configureCellBlock(cell, obj)
        XCTAssertEqual(TableViewCellPresenterTests.blockExecutionTest, "testExecuted")
    }

    func test_tableViewCellPresenterFields_reuseIdentifier() {
        let presenter = self.createTableViewCellPresenter()
         XCTAssertEqual(presenter.cellReuseIdentifier, TableViewCellPresenterTests.cellReuseId)
    }
    
}
