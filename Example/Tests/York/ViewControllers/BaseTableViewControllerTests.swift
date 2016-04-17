import XCTest
import York

class BaseTableViewControllerTests: XCTestCase {
    
    var viewController: BaseTableViewController!
    
    override func setUp() {
        super.setUp()
        let appContext = TestUtil().appContext()
        let navigationController = TestUtil().rootViewController()
        viewController = TestUtil().baseTableViewController(appContext)
        navigationController.pushViewController(viewController, animated: true)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        
        let _ = navigationController.view
        let _ = viewController.view
    }
    
//    func test_viewDidLoad_mustNotCrash() {
//        self.viewController.viewDidLoad()
//    }

//    func test_viewDidAppear_mustNotCrash() {
//        self.viewController.viewDidAppear(true)
//    }
    
    
//    func test_viewWillDisappear_mustNotCrash() {
//        self.viewController.viewWillDisappear(true)
//    }
    
    
//    func test_defaultEmptyResultsBackgroundView_mustReturnNil() {
//        XCTAssertNil(self.viewController.defaultEmptyResultsBackgroundView())
//    }
    
//    func test_defaultNonEmptyResultsBackgroundView_mustReturnNil() {
//        XCTAssertNil(self.viewController.defaultNonEmptyResultsBackgroundView())
//    }
    
    
//    func test_setupTableView_mustNotCrash() {
//        self.viewController.setupTableView()
//    }

    
//    func test_createDataSource_mustReturnNil() {
//        XCTAssertNil(self.viewController.createDataSource())
//    }
    
    
//    func test_createDelegate_mustReturnNil() {
//        XCTAssertNil(self.viewController.createDelegate())
//    }
    
    
//    func test_performDataSync_mustNotCrash() {
//        self.viewController.performDataSync()
//    }
    
    
//    func test_dataSyncCompleted_mustNotCrash() {
//        self.viewController.dataSyncCompleted()
//    }
    
}
