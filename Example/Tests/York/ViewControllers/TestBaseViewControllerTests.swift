import XCTest
import York

class TestBaseViewControllerTests: XCTestCase {
    
    var viewController: TestBaseViewController!
    
    override func setUp() {
        super.setUp()
        let appContext = TestUtil().appContext()
        let navigationController = TestUtil().rootViewController()
        viewController = TestUtil().testBaseViewController(appContext)
        navigationController.pushViewController(viewController, animated: true)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        
        let _ = navigationController.view
        let _ = viewController.view
    }
    
//    func test_appContext_notNil() {
//        XCTAssertNotNil(viewController.appContext)
//    }
    
//    func test_viewControllerTitle_nil() {
//        let bundle = NSBundle(forClass: self.dynamicType)
//        let viewControllerTitle = NSLocalizedString("VC_TEST_BASE_VIEW_CONTROLLER", tableName: nil, bundle: bundle, value: "", comment: "")
//        XCTAssertEqual(viewController.viewControllerTitle(), viewControllerTitle)
//    }
    
}
