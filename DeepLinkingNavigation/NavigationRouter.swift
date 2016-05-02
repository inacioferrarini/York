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

import JLRoutes
import UIKit

public class NavigationRouter: NSObject {

    public let router: JLRoutes
    public let schema: String
    public let logger: Logger

    public init(router: JLRoutes, schema: String, logger: Logger) {
        self.router = router
        self.schema = schema
        self.logger = logger
        super.init()
    }

    public convenience init(schema: String, logger: Logger) {
        self.init(router: JLRoutes(forScheme: schema), schema: schema, logger: logger)
    }

    public func registerRoutes(appRoutes: [RoutingElement]) {
        for r: RoutingElement in appRoutes {
            self.router.addRoute(r.path.absoluteString(), handler: r.handler)
        }
    }

    public func dispatch(url: NSURL) -> Bool {
        let result = self.router.canRouteURL(url)
        if result {
            self.router.routeURL(url)
        }
        return result
    }

    public func navigateInternal(targetUrl: String) {
        let completeUrl = NSURL(string: "\(self.schema):/\(targetUrl)")
        if let url = completeUrl {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    public func navigateExternal(targetUrl: String) {
        let completeUrl = NSURL(string: targetUrl)
        if let url = completeUrl {
            UIApplication.sharedApplication().openURL(url)
        }
    }

}
