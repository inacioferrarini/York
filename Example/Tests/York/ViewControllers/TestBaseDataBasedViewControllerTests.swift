import XCTest
import York

class TestBaseDataBasedViewControllerTests: XCTestCase {
    
    var viewController: BaseDataBasedViewController!
    
    override func setUp() {
        super.setUp()
        let appContext = TestUtil().appContext()
        let navigationController = TestUtil().rootViewController()
        viewController = TestUtil().testBaseDataBasedViewController(appContext)
        navigationController.pushViewController(viewController, animated: true)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        
        let _ = navigationController.view
        let _ = viewController.view
    }
    
    
//    func test_shouldSyncData_mustReturnsTrue() {
//        XCTAssertTrue(self.viewController.shouldSyncData())
//    }
    
//    func test_showCourtainView_withCourtain() {
//        self.viewController.showCourtainView()
//        XCTAssertFalse(self.viewController.courtain?.hidden ?? true)
//    }
    
//    func test_hideCourtainView_withCourtain() {
//        self.viewController.hideCourtainView()
//        XCTAssertTrue(self.viewController.courtain?.hidden ?? false)
//    }
    
//    func test_performDataSyncIfNeeded() {
//        self.viewController.performDataSyncIfNeeded()
//    }
    
}
