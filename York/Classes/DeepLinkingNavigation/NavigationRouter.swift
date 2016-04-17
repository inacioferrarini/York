import JLRoutes
import UIKit

public class NavigationRouter: NSObject {
    
    public let router:JLRoutes
    public let schema:String
    public let logger:Logger
    
    public init(router: JLRoutes, schema: String, logger: Logger) {
        self.router = router
        self.schema = schema
        self.logger = logger
        super.init()
    }

    public convenience init(schema:String, logger: Logger) {
        self.init(router: JLRoutes(forScheme: schema), schema: schema, logger: logger)
    }
    
    public func registerRoutes(appRoutes: [RoutingElement]) {
        for r:RoutingElement in appRoutes {
            self.router.addRoute(r.pattern, handler: r.handler)
        }
    }
    
    public func dispatch(url:NSURL) -> Bool {
        let result = self.router.canRouteURL(url)
        if (result) {
            self.router.routeURL(url)
        }
        return result
    }
    
    public func navigateInternal(targetUrl:String) {
        let completeUrl = NSURL(string: "\(self.schema):/\(targetUrl)")
        if let url = completeUrl {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    public func navigateExternal(targetUrl:String) {
        let completeUrl = NSURL(string: targetUrl)
        if let url = completeUrl {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
}
