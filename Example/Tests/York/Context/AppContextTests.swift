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

class AppContextTests: XCTestCase {
    
    
    // MARK: - Properties
    
    var logger: Logger!
    var navigationController: UINavigationController!
    var coreDataStack: CoreDataStack!
    var syncRules: DataSyncRules!
    var router: NavigationRouter!
    
    
    // MARK: - Supporting Methods
    
    func createAppContext() -> AppContext {
        self.logger = Logger(logProvider: TestLogProvider())
        self.navigationController = UINavigationController()
        self.coreDataStack = TestUtil().appContext().coreDataStack
        self.syncRules = DataSyncRules(coreDataStack: coreDataStack)
        self.router = NavigationRouter(schema: "", logger: self.logger)
        
        return AppContext(navigationController: self.navigationController,
            coreDataStack: self.coreDataStack,
            syncRules: self.syncRules,
            router: self.router,
            logger: self.logger)
    }
    
    
    // MARK: - Tests - Fields
    
    func test_AppContextFields_logger() {
        let appContext = self.createAppContext()
        XCTAssertEqual(appContext.logger, self.logger)
    }
    
    func test_AppContextFields_navigationController() {
        let appContext = self.createAppContext()
        XCTAssertEqual(appContext.navigationController, self.navigationController)
    }
    
    func test_AppContextFields_coreDataStack() {
        let appContext = self.createAppContext()
        XCTAssertEqual(appContext.coreDataStack, self.coreDataStack)
    }
    
    func test_AppContextFields_syncRules() {
        let appContext = self.createAppContext()
        XCTAssertEqual(appContext.syncRules, self.syncRules)
    }
    
    func test_AppContextFields_router() {
        let appContext = self.createAppContext()
        XCTAssertEqual(appContext.router, self.router)
    }
    
}
