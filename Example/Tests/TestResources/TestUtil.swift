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
