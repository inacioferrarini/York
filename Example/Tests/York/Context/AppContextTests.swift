import XCTest
import York

class AppContextTests: XCTestCase {
    
    var logger: Logger!
    var navigationController: UINavigationController!
    var coreDataStack: CoreDataStack!
    var syncRules: DataSyncRules!
    var router: NavigationRouter!
    
    func createAppContext() -> AppContext {
        self.logger = Logger()
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
