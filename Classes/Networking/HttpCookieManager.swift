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

open class HttpCookieManager {

    open let domainUrl: URL


    // MARK: - Initialization

    public init(domain url: URL) {
        self.domainUrl = url
    }


    // MARK: - Properties

    open var cookieStorage: HTTPCookieStorage {
        get {
            return HTTPCookieStorage.shared
        }
    }

    open var userDefaults: UserDefaults {
        get {
            return UserDefaults.standard
        }
    }

    open var cookieStorageKey: String {
        get {
            return "httpCookies"
        }
    }


    // MARK: - Public Properties

    open func cookiesFromResponse(fromResponse response: URLResponse? /* fromDataTask dataTask: NSURLSessionDataTask*/) -> [HTTPCookie] {
        let emptyArray = [HTTPCookie]()
        guard let response = response as? HTTPURLResponse else { return emptyArray }
        guard let headerFields = response.allHeaderFields as? [String: String] else { return emptyArray }
        return HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: self.domainUrl)
    }

    open func setCookies(_ cookies: [HTTPCookie], expiresDate: Date?) {
        for cookie in cookies {
            if let newCookie = self.updateCookieExpireTime(cookie, expiresDate: expiresDate) {
                self.cookieStorage.setCookie(newCookie)
            }
        }
    }

    open func updateCookieExpireTime(_ cookie: HTTPCookie, expiresDate: Date?) -> HTTPCookie? {
        var cookieProperties = [HTTPCookiePropertyKey: Any]()
        cookieProperties[HTTPCookiePropertyKey.name] = cookie.name
        cookieProperties[HTTPCookiePropertyKey.value] = cookie.value
        cookieProperties[HTTPCookiePropertyKey.domain] = cookie.domain
        cookieProperties[HTTPCookiePropertyKey.path] = cookie.path
        cookieProperties[HTTPCookiePropertyKey.version] = NSNumber(value: cookie.version as Int)
        if let expiresDate = expiresDate {
            cookieProperties[HTTPCookiePropertyKey.expires] = expiresDate
        } else {
            cookieProperties[HTTPCookiePropertyKey.expires] = nil
        }
        return HTTPCookie(properties: cookieProperties)
    }

    open func saveCookies() {
        guard let cookies = self.cookieStorage.cookies else { return }
        let cookiesData = NSKeyedArchiver.archivedData(withRootObject: cookies)
        let defaults = self.userDefaults
        defaults.set(cookiesData, forKey: self.cookieStorageKey)
        defaults.synchronize()
    }

    open func loadCookies() {
        guard let cookiesData = self.userDefaults.object(forKey: self.cookieStorageKey) as? Data else { return }
        guard let cookies = NSKeyedUnarchiver.unarchiveObject(with: cookiesData) as? [HTTPCookie] else { return }
        for cookie in cookies {
            self.cookieStorage.setCookie(cookie)
        }
    }

    open func removeAllCookies() {
        if let cookies = self.cookieStorage.cookies {
            for cookie in cookies {
                self.cookieStorage.deleteCookie(cookie)
            }
        }
    }

}
