import XCTest
import York

class TestBaseTableViewControllerTests: XCTestCase {
    
    var viewController: TestBaseTableViewController!
    
    override func setUp() {
        super.setUp()
        let appContext = TestUtil().appContext()
        let navigationController = TestUtil().rootViewController()
        viewController = TestUtil().testBaseTableViewController(appContext)
        navigationController.pushViewController(viewController, animated: true)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        
        let _ = navigationController.view
        let _ = viewController.view
    }
    
    
//    func test_viewDidLoad_mustNotCrash() {
//        self.viewController.viewDidLoad()
//    }

    
//    func test_viewWillDisappear_mustNotCrash() {
//        self.viewController.viewDidLoad()
//        let context = self.viewController.appContext.coreDataStack.managedObjectContext
//        EntitySyncHistory.removeAll(inManagedObjectContext: context)
//        
//        let ruleName = TestUtil().randomRuleName()
//        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
//            lastExecutionDate: nil,
//            inManagedObjectContext: context)
//        
//        let dataSource = self.viewController.dataSource as! FetcherDataSource<UITableViewCell, EntitySyncHistory>
//        dataSource.refreshData()
//        self.viewController.tableView!.reloadData()
//
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.viewController.tableView!.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Top)
//
//        self.viewController.viewWillDisappear(true)
//    }
    
    
//    func test_createDataSource_mustReturnNotNil() {
//        XCTAssertNotNil(self.viewController.createDataSource())
//    }
    
//    func test_dataSource_checkPresenterConfigureCellBlock() {
//        self.viewController.viewDidLoad()
//        let dataSource = self.viewController.dataSource as! FetcherDataSource<UITableViewCell, EntitySyncHistory>
//        let coreDataStack = TestUtil().appContext().coreDataStack
//        let ctx = coreDataStack.managedObjectContext
//        let ruleName = TestUtil().randomRuleName()
//        let testEntity = EntitySyncHistory.entityAutoSyncHistoryByName(ruleName, lastExecutionDate: nil, inManagedObjectContext: ctx)
//        let cell = UITableViewCell()
//        dataSource.presenter.configureCellBlock(cell, testEntity!)
//    }
    
    
//    func test_createDelegate_mustReturnNotNil() {
//        XCTAssertNotNil(self.viewController.createDelegate())
//    }
    
//    func test_delegate_checkItemSelectionBlock() {
//        self.viewController.viewDidLoad()
//        let delegate = self.viewController.delegate as! TableViewBlockDelegate
//        delegate.itemSelectionBlock(indexPath: NSIndexPath(forRow: 0, inSection: 0))
//    }
    
    
//    func test_dataSyncCompleted_mustNotCrash() {
//        self.viewController.dataSyncCompleted()
//    }
    
}
