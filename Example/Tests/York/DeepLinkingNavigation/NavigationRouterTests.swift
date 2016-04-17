import XCTest
import JLRoutes
import York

class NavigationRouterTests: XCTestCase {
    
    override func setUp() {
        self.router = self.createNavigationRouter()
        self.routeWasCalled = false
        super.setUp()
    }
    
    var routeWasCalled:Bool = false
    var router:NavigationRouter!
    
    func createNavigationRouter() -> NavigationRouter {
        JLRoutes.setVerboseLoggingEnabled(true)
        let navigationRouter = NavigationRouter(schema: "TesteScheme", logger: Logger())
        let route = RoutingElement(pattern: "/testUrlScheme") { (params: [NSObject : AnyObject]) -> Bool in
            self.routeWasCalled = true
            return true
        }
        navigationRouter.registerRoutes([route])
        return navigationRouter
    }
    
//    func test_dispatch_mustReturnTrue() {
//        let result = self.router.dispatch(NSURL(string: "TesteScheme://testUrlScheme")!)
//        XCTAssertTrue(result)
//    }
    
//    func test_dispatch_mustReturnFalse() {
//        let result = self.router.dispatch(NSURL(string: "TesteScheme://invalidTestUrlScheme")!)
//        XCTAssertFalse(result)
//    }
    
//    func test_navigateInternal_mustSucceed() {
//        self.router.navigateInternal("/testUrlScheme")
//    }
    
//    func test_navigateInternal_mustFail() {
//        self.router.navigateInternal("/invalidTestUrlScheme")
//    }
    
//    func test_navigateExternal_mustSucceed() {
//        self.router.navigateExternal("http://www.google.com.br")
//    }
    
//    func test_navigateExternal_mustFail() {
//        self.router.navigateExternal("http://x/")
//    }
    
}