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

import UIKit

public class HttpCookieManager {

    public let domainUrl: NSURL


    // MARK: - Initialization

    public init(domain url: NSURL) {
        self.domainUrl = url
    }


    // MARK: - Properties

    public var cookieStorage: NSHTTPCookieStorage {
        get {
            return NSHTTPCookieStorage.sharedHTTPCookieStorage()
        }
    }

    public var userDefaults: NSUserDefaults {
        get {
            return NSUserDefaults.standardUserDefaults()
        }
    }

    public var cookieStorageKey: String {
        get {
            return "httpCookies"
        }
    }


    // MARK: - Public Properties

    public func cookiesFromResponse(fromResponse response: NSURLResponse? /* fromDataTask dataTask: NSURLSessionDataTask*/) -> [NSHTTPCookie] {
        let emptyArray = [NSHTTPCookie]()
        guard let response = response as? NSHTTPURLResponse else { return emptyArray }
        guard let headerFields = response.allHeaderFields as? [String: String] else { return emptyArray }
        return NSHTTPCookie.cookiesWithResponseHeaderFields(headerFields, forURL: self.domainUrl)
    }

    public func setCookies(cookies: [NSHTTPCookie], expiresDate: NSDate?) {
        for cookie in cookies {
            if let newCookie = self.updateCookieExpireTime(cookie, expiresDate: expiresDate) {
                self.cookieStorage.setCookie(newCookie)
            }
        }
    }

    public func updateCookieExpireTime(cookie: NSHTTPCookie, expiresDate: NSDate?) -> NSHTTPCookie? {
        var cookieProperties = [String: AnyObject]()
        cookieProperties[NSHTTPCookieName] = cookie.name
        cookieProperties[NSHTTPCookieValue] = cookie.value
        cookieProperties[NSHTTPCookieDomain] = cookie.domain
        cookieProperties[NSHTTPCookiePath] = cookie.path
        cookieProperties[NSHTTPCookieVersion] = NSNumber(integer: cookie.version)
        if let expiresDate = expiresDate {
            cookieProperties[NSHTTPCookieExpires] = expiresDate
        } else {
            cookieProperties[NSHTTPCookieExpires] = nil
        }
        return NSHTTPCookie(properties: cookieProperties)
    }

    public func saveCookies() {
        guard let cookies = self.cookieStorage.cookies else { return }
        let cookiesData = NSKeyedArchiver.archivedDataWithRootObject(cookies)
        let defaults = self.userDefaults
        defaults.setObject(cookiesData, forKey: self.cookieStorageKey)
        defaults.synchronize()
    }

    public func loadCookies() {
        guard let cookiesData = self.userDefaults.objectForKey(self.cookieStorageKey) as? NSData else { return }
        guard let cookies = NSKeyedUnarchiver.unarchiveObjectWithData(cookiesData) as? [NSHTTPCookie] else { return }
        for cookie in cookies {
            self.cookieStorage.setCookie(cookie)
        }
    }

    public func removeAllCookies() {
        if let cookies = self.cookieStorage.cookies {
            for cookie in cookies {
                self.cookieStorage.deleteCookie(cookie)
            }
        }
    }

}
