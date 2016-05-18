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


    // MARK: - Constants

    static let modelFileName = "DataSyncRules"
    static let databaseFileName = "DataSyncRulesDB"

    static let testModelFileName = "YorkTests"
    static let testDatabaseFileName = "YorkTestsDB"


    // MARK: - Test Bundles

    func yorkPODBundle() -> NSBundle {
        return NSBundle(forClass: FullStackAppContext.self)
    }

    func mainBundle() -> NSBundle {
        return NSBundle.mainBundle()
    }

    func unitTestsBundle() -> NSBundle {
        return NSBundle(forClass: self.dynamicType)
    }

    // MARK: - Utility Methods

    func appContext() -> FullStackAppContext {

        let appBundle = self.yorkPODBundle()
        let logger = Logger(logProvider: TestLogProvider())
        var viewControllers = Dictionary<String, UIViewController>()
        viewControllers["navigationController"] = self.rootViewController()
        let stack = CoreDataStack(modelFileName: TestUtil.modelFileName, databaseFileName: TestUtil.databaseFileName, logger: logger, bundle: appBundle)
        let router = NavigationRouter(schema: "GitHubSpy", logger: logger)
        let syncRulesStack = CoreDataStack(modelFileName: TestUtil.modelFileName, databaseFileName: TestUtil.databaseFileName, logger: logger, bundle: appBundle)
        let syncRules = DataSyncRules(coreDataStack: syncRulesStack)

        return FullStackAppContext(viewControllers: viewControllers,
                                   coreDataStack: stack,
                                   syncRules: syncRules,
                                   router: router,
                                   logger: logger)
    }

    func testAppContext() -> FullStackAppContext {

        let appBundle = self.yorkPODBundle()
        let testsBundle = self.unitTestsBundle()
        let logger = Logger(logProvider: TestLogProvider())
        var viewControllers = Dictionary<String, UIViewController>()
        viewControllers["navigationController"] = self.rootViewController()
        let stack = CoreDataStack(modelFileName: TestUtil.testModelFileName, databaseFileName: TestUtil.testDatabaseFileName, logger: logger, bundle: testsBundle)
        let router = NavigationRouter(schema: "GitHubSpy", logger: logger)
        let syncRulesStack = CoreDataStack(modelFileName: TestUtil.modelFileName, databaseFileName: TestUtil.databaseFileName, logger: logger, bundle: appBundle)
        let syncRules = DataSyncRules(coreDataStack: syncRulesStack)

        return FullStackAppContext(viewControllers: viewControllers,
                                   coreDataStack: stack,
                                   syncRules: syncRules,
                                   router: router,
                                   logger: logger)
    }

    func randomString() -> String {
        return NSUUID().UUIDString.stringByReplacingOccurrencesOfString("-", withString: "")
    }


    // MARK: - Test View Controllers

    func baseTabBarController() -> BaseTabBarController {
        let bundle = self.unitTestsBundle()
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        if let viewController = storyBoard.instantiateViewControllerWithIdentifier("BaseTabBarController") as? BaseTabBarController {
            return viewController
        }
        return BaseTabBarController()
    }

    func rootViewController() -> UINavigationController {
        let bundle = self.unitTestsBundle()
        XCTAssertNotNil(bundle, "BUNDLE EXPECTED")
        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        XCTAssertNotNil(storyBoard, "storyBoard EXPECTED")
        if let viewController = storyBoard.instantiateInitialViewController() as? UINavigationController {
            return viewController
        }
        return UINavigationController()
    }

//    func testBaseViewController(appContext: FullStackAppContext!) -> TestBaseViewController? {
//        let bundle = self.unitTestsBundle()
//        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
//        if let viewController = storyBoard.instantiateViewControllerWithIdentifier("TestBaseViewController") as? TestBaseViewController {
//            viewController.appContext = appContext
//            return viewController
//        }
//        return nil
//    }
//
//    func baseDataBasedViewController(appContext: FullStackAppContext!) -> BaseDataBasedViewController<FullStackAppContext>? {
//        let bundle = self.unitTestsBundle()
//        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
//        if let viewController = storyBoard.instantiateViewControllerWithIdentifier("BaseDataBasedViewController") as? BaseDataBasedViewController<FullStackAppContext> {
//            viewController.appContext = appContext
//            return viewController
//        }
//        return nil
//    }
//
//    func testBaseDataBasedViewController(appContext: FullStackAppContext!) -> TestBaseDataBasedViewController? {
//        let bundle = self.unitTestsBundle()
//        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
//        if let viewController = storyBoard.instantiateViewControllerWithIdentifier("TestBaseDataBasedViewController") as? TestBaseDataBasedViewController {
//            viewController.appContext = appContext
//            return viewController
//        }
//        return nil
//    }
//
//    func baseTableViewController(appContext: FullStackAppContext!) -> BaseTableViewController<FullStackAppContext>? {
//        let bundle = self.unitTestsBundle()
//        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
//        if let viewController = storyBoard.instantiateViewControllerWithIdentifier("BaseTableViewController") as? BaseTableViewController<FullStackAppContext> {
//            viewController.appContext = appContext
//            return viewController
//        }
//        return nil
//    }
//
//    func testBaseTableViewController(appContext: FullStackAppContext!) -> TestBaseTableViewController? {
//        let bundle = self.unitTestsBundle()
//        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
//        if let viewController = storyBoard.instantiateViewControllerWithIdentifier("TestBaseTableViewController") as? TestBaseTableViewController {
//            viewController.appContext = appContext
//            return viewController
//        }
//        return nil
//    }
//
//    func testClassicTableViewController(appContext: FullStackAppContext!) -> TestClassicTableViewController? {
//        let bundle = self.unitTestsBundle()
//        let storyBoard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
//        if let viewController = storyBoard.instantiateViewControllerWithIdentifier("TestClassicTableViewController") as? TestClassicTableViewController {
//            viewController.appContext = appContext
//            return viewController
//        }
//        return nil
//    }

}
