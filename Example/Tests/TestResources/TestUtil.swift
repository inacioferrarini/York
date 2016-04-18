import XCTest
import York

class TestUtil: NSObject {

    static let modelFileName = "DataSyncRules"
    static let databaseFileName = "DataSyncRulesDB"
    
    func yorkPODBundle() -> NSBundle {        
        return NSBundle(forClass: AppContext.self)
    }
    
    func mainBundle() -> NSBundle {
        return NSBundle.mainBundle()
    }
    
    func unitTestsBundle() -> NSBundle {
        return NSBundle(forClass: self.dynamicType)
    }
    
    func appContext() -> AppContext {
        
        // let appBundle = self.mainBundle()
        let appBundle = self.yorkPODBundle()
        let logger = Logger()
        let rootNavigationController = self.rootViewController()
        let stack = CoreDataStack(modelFileName: TestUtil.modelFileName, databaseFileName: TestUtil.databaseFileName, logger: logger, bundle: appBundle)
        let router = NavigationRouter(schema: "GitHubSpy", logger: logger)
        let syncRulesStack = CoreDataStack(modelFileName: TestUtil.modelFileName, databaseFileName: TestUtil.databaseFileName, logger: logger, bundle: appBundle)
        let syncRules = DataSyncRules(coreDataStack: syncRulesStack)
        
        return AppContext(navigationController: rootNavigationController,
            coreDataStack: stack,
            syncRules: syncRules,
            router: router,
            logger: logger)
    }
    
    func randomRuleName() -> String {
        return NSUUID().UUIDString.stringByReplacingOccurrencesOfString("-", withString: "")
    }
    
    func rootViewController() -> UINavigationController {
        let bundle = self.unitTestsBundle()
XCTAssertNotNil(bundle, "BUNDLE EXPECTED")
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
XCTAssertNotNil(storyBoard, "storyBoard EXPECTED")
        return storyBoard.instantiateInitialViewController() as! UINavigationController
    }
    
    func testBaseViewController(appContext: AppContext!) -> TestBaseViewController {
        let bundle = self.unitTestsBundle()
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("TestBaseViewController") as! TestBaseViewController
        viewController.appContext = appContext
        return viewController
    }
    
    func baseDataBasedViewController(appContext: AppContext!) -> BaseDataBasedViewController {
        let bundle = self.unitTestsBundle()
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("BaseDataBasedViewController") as! BaseDataBasedViewController
        viewController.appContext = appContext
        return viewController
    }
    
    func testBaseDataBasedViewController(appContext: AppContext!) -> TestBaseDataBasedViewController {
        let bundle = self.unitTestsBundle()
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("TestBaseDataBasedViewController") as! TestBaseDataBasedViewController
        viewController.appContext = appContext
        return viewController
    }

    func baseTableViewController(appContext: AppContext!) -> BaseTableViewController {
        let bundle = self.unitTestsBundle()
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("BaseTableViewController") as! BaseTableViewController
        viewController.appContext = appContext
        return viewController
    }
    
    func testBaseTableViewController(appContext: AppContext!) -> TestBaseTableViewController {
        let bundle = self.unitTestsBundle()
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("TestBaseTableViewController") as! TestBaseTableViewController
        viewController.appContext = appContext
        return viewController
    }
    
    func testClassicTableViewController(appContext: AppContext!) -> TestClassicTableViewController {
        let bundle = self.unitTestsBundle()
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("TestClassicTableViewController") as! TestClassicTableViewController
        viewController.appContext = appContext
        return viewController
    }
    
}
