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
import JLRoutes
import York

class NavigationRouterTests: XCTestCase {

    
    // MARK: - Properties
    
    var routeWasCalled:Bool = false
    var router:NavigationRouter!
    
    
    // MARK: - Tests Setup
    
    override func setUp() {
        self.router = self.createNavigationRouter()
        self.routeWasCalled = false
        super.setUp()
    }
    
    
    // MARK: - Supporting Methods
    
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
    
    
    // MARK: - Tests
    
    func test_dispatch_mustReturnTrue() {
        let result = self.router.dispatch(NSURL(string: "TesteScheme://testUrlScheme")!)
        XCTAssertTrue(result)
    }
    
    func test_dispatch_mustReturnFalse() {
        let result = self.router.dispatch(NSURL(string: "TesteScheme://invalidTestUrlScheme")!)
        XCTAssertFalse(result)
    }
    
    func test_navigateInternal_mustSucceed() {
        self.router.navigateInternal("/testUrlScheme")
    }
    
    func test_navigateInternal_mustFail() {
        self.router.navigateInternal("/invalidTestUrlScheme")
    }
    
    func test_navigateExternal_mustSucceed() {
        self.router.navigateExternal("http://www.google.com.br")
    }
    
    func test_navigateExternal_mustFail() {
        self.router.navigateExternal("http://x/")
    }
    
}