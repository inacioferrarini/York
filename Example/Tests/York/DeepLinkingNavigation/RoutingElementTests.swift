import XCTest
import York

class RoutingElementTests: XCTestCase {

    static let pattern = "TestRoute"
    static var blockExecutionTest = ""
    
    func createRoute() -> RoutingElement {
        return RoutingElement(pattern: RoutingElementTests.pattern, handler: { (parameters:[NSObject : AnyObject]) -> Bool in
            RoutingElementTests.blockExecutionTest = "testExecuted"
            return true
        })
    }
    
//    func test_routingElementFields_configureHandlerBlock() {
//        let route = self.createRoute()
//        route.handler(["" : ""])
//        XCTAssertEqual(RoutingElementTests.blockExecutionTest, "testExecuted")
//    }
    
//    func test_routingElementFields_pattern() {
//        let route = self.createRoute()
//        XCTAssertEqual(route.pattern, RoutingElementTests.pattern)
//    }
    
}