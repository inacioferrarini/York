import XCTest
import York

class BaseDataBasedViewControllerTests: XCTestCase {
    
    var viewController: BaseDataBasedViewController!
    
    override func setUp() {
        super.setUp()
        let appContext = TestUtil().appContext()
        let navigationController = TestUtil().rootViewController()
        viewController = TestUtil().baseDataBasedViewController(appContext)
        navigationController.pushViewController(viewController, animated: true)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        
        let _ = navigationController.view
        let _ = viewController.view
    }
    
//    func test_viewDidAppear() {
//        self.viewController.viewDidAppear(true)
//    }
    
    
//    func test_shouldSyncData_mustReturnsFalse() {
//        XCTAssertFalse(self.viewController.shouldSyncData())
//    }
    
    
//    func test_perforDataSync() {
//        self.viewController.performDataSync()
//    }
    
    
//    func test_showCourtainView_withoutCourtain() {
//        self.viewController.showCourtainView()
//    }
    
//    func test_showCourtainView_withCourtain() {
//        self.viewController.showCourtainView()
//    }
    
    
//    func test_hideCourtainView_withoutCourtain() {
//        self.viewController.hideCourtainView()
//    }
    
//    func test_hideCourtainView_withCourtain() {
//        self.viewController.hideCourtainView()
//    }

    
//    func test_performDataSyncIfNeeded() {
//        self.viewController.performDataSyncIfNeeded()
//    }
    
    

    
    
//    func showCourtainView() {
//        if let courtain = self.courtain {
//            courtain.hidden = false
//        }
//        self.view.userInteractionEnabled = false
//    }
//    
//    func hideCourtainView() {
//        if let courtain = self.courtain {
//            courtain.hidden = true
//        }
//        self.view.userInteractionEnabled = true
//    }

    
    
}
