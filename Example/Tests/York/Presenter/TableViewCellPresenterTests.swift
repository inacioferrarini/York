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
    
//    func test_tableViewCellPresenterFields_configureCellBlock() {
//        let logger = Logger()
//        let dataSyncRulesStack = CoreDataStack(modelFileName: TableViewCellPresenterTests.modelFileName, databaseFileName: TableViewCellPresenterTests.databaseFileName, logger: logger)        
//        let presenter = self.createTableViewCellPresenter()
//        let cell = UITableViewCell()
//        let ctx = dataSyncRulesStack.managedObjectContext
//        let obj = EntitySyncHistory.entityAutoSyncHistoryByName("xpto", lastExecutionDate: nil, inManagedObjectContext: ctx)!
//        presenter.configureCellBlock(cell, obj)
//        XCTAssertEqual(TableViewCellPresenterTests.blockExecutionTest, "testExecuted")
//    }
//
//    func test_tableViewCellPresenterFields_reuseIdentifier() {
//        let presenter = self.createTableViewCellPresenter()
//         XCTAssertEqual(presenter.cellReuseIdentifier, TableViewCellPresenterTests.cellReuseId)
//    }
    
}
