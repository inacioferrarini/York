import UIKit

public class RoutingElement: NSObject {

    public let pattern:String
    public let handler:(([NSObject : AnyObject]) -> Bool)
    
    public init(pattern:String, handler:(([NSObject : AnyObject]) -> Bool)) {
        self.pattern = pattern
        self.handler = handler
        super.init()
    }
    
}
