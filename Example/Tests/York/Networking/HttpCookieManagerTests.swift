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
import AFNetworking

class HttpCookieManagerTests: XCTestCase {


    // MARK: - Properties

    var cookieManager: HttpCookieManager!
    var testsCookieManager: TestsHttpCookieManager!
    let testUrl = NSURL(string: "www.google.com")!


    // MARK: - Tests Setup

    override func setUp() {
        super.setUp()
        self.cookieManager = HttpCookieManager(domain: self.testUrl)
        self.testsCookieManager = TestsHttpCookieManager(domain: self.testUrl)
    }

    override func tearDown() {
        self.cookieManager = nil
        self.testsCookieManager = nil
        super.tearDown()
    }


    // MARK: - Tests

    func test_initParameters() {
        XCTAssertEqual(self.testUrl, self.cookieManager.domainUrl)
    }


    // MARK: - Updating Expire Time
    
    func test_updateCookieExpireTime_withExpirationTime_mustUpdateCookie() {
        var cookie = NSHTTPCookie(properties: [NSHTTPCookieName : "cookie name",
            NSHTTPCookieValue : "value",
            NSHTTPCookieDomain : "www.google.com.br",
            NSHTTPCookiePath : "/",
            NSHTTPCookieVersion : 0])
        let expiresDate = NSDate().dateByAddingTimeInterval(30 * 60)
        cookie = self.cookieManager.updateCookieExpireTime(cookie!, expiresDate: expiresDate)!
        XCTAssertNotNil(cookie?.expiresDate)
    }

    func test_updateCookieExpireTime_withoutExpirationTime_mustUpdateCookie() {
        var cookie = NSHTTPCookie(properties: [NSHTTPCookieName : "cookie name",
            NSHTTPCookieValue : "value",
            NSHTTPCookieDomain : "www.google.com.br",
            NSHTTPCookiePath : "/",
            NSHTTPCookieVersion : 0])
        cookie = self.cookieManager.updateCookieExpireTime(cookie!, expiresDate: nil)!
        XCTAssertNil(cookie?.expiresDate)
    }


    // MARK: - Saving and Loading
    
    func test_saveCookies_mustNotCrash() {
        self.cookieManager.saveCookies()
    }

    func test_saveCookies_withoutCookies_mustNotCrash() {
        self.testsCookieManager.saveCookies()
    }

    func test_loadCookies_mustNotCrash() {
        self.cookieManager.loadCookies()
    }

    func test_loadCookies_withoutObjectInDefaults_mustNotCrash() {
        self.cookieManager.userDefaults.removeObjectForKey(cookieManager.cookieStorageKey)
        self.cookieManager.userDefaults.synchronize()
        self.cookieManager.loadCookies()
    }

    func test_loadCookies_withoutArchivedData_mustNotCrash() {
        self.cookieManager.userDefaults.setObject(nil, forKey: cookieManager.cookieStorageKey)
        self.cookieManager.userDefaults.synchronize()
        self.cookieManager.loadCookies()
    }

    func test_loadCookies_withEmptyArchivedData_mustNotCrash() {
        let cookiesData = NSKeyedArchiver.archivedDataWithRootObject([10, 20, 30, 40])
        self.cookieManager.userDefaults.setObject(cookiesData, forKey: self.cookieManager.cookieStorageKey)
        self.cookieManager.userDefaults.synchronize()
        self.cookieManager.loadCookies()
    }

    func test_loadCookies_withArchivedData_mustNotCrash() {
        let cookie = NSHTTPCookie(properties: [NSHTTPCookieName : "cookie name",
            NSHTTPCookieValue : "value",
            NSHTTPCookieDomain : "www.google.com.br",
            NSHTTPCookiePath : "/",
            NSHTTPCookieVersion : 0])
        let expiresDate = NSDate().dateByAddingTimeInterval(30 * 60)
        self.cookieManager.setCookies([cookie!], expiresDate: expiresDate)
        self.cookieManager.saveCookies()
        self.cookieManager.loadCookies()
    }

    func test_loadCookiesAfterSaving_mustNotCrash() {
        let cookie = NSHTTPCookie(properties: [NSHTTPCookieName : "cookieName",
            NSHTTPCookieValue : "cookieValue",
            NSHTTPCookiePath : "/",
            NSHTTPCookieDomain: "www.google.com"])
        self.cookieManager.setCookies([cookie!], expiresDate: nil)
        self.testsCookieManager.saveCookies()
        self.cookieManager.loadCookies()
    }


    // MARK: - Removing Cookies

    func test_removeAllCookies_withCookies_mustRemoveCookies() {
        let cookie = NSHTTPCookie(properties: [NSHTTPCookieName : "cookieName",
            NSHTTPCookieValue : "cookieValue",
            NSHTTPCookiePath : "/",
            NSHTTPCookieDomain: "www.google.com"])
        self.cookieManager.setCookies([cookie!], expiresDate: nil)
        
        self.cookieManager.removeAllCookies()
        XCTAssertEqual(self.cookieManager.cookieStorage.cookies?.count, 0)
    }

    func test_removeAllCookies_withoutCookies_mustRemoveCookies() {
        self.testsCookieManager.removeAllCookies()
        XCTAssertNil(self.testsCookieManager.cookieStorage.cookies)
    }


    // MARK: - cookiesFromResponse

    func test_cookiesFromResponse_mustParseCookies() {
        let expectation = self.expectationWithDescription("asynchronous request")

        let successBlock = { (dataTask: NSURLSessionDataTask, responseObject:AnyObject?) -> Void in
            let cookies = self.cookieManager.cookiesFromResponse(fromResponse: dataTask.response)
            self.cookieManager.setCookies(cookies, expiresDate: nil)
            self.cookieManager.saveCookies()
            expectation.fulfill()
        }

        let failureBlock = { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
            expectation.fulfill()
        }

        if let url = NSURL(string: "http://www.google.com") {
            let manager = AFHTTPSessionManager(baseURL: url)
            let targetUrl = "/"
            manager.responseSerializer = AFHTTPResponseSerializer()
            manager.GET(targetUrl, parameters: nil, progress: nil, success: successBlock, failure: failureBlock)
        }

        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }

    func test_cookiesFromResponse_withWeirdResponse() {
        let dataTask = TestsNSURLSessionDataTask()
        dataTask.responseToUse = nil
        let cookies = self.cookieManager.cookiesFromResponse(fromResponse: dataTask.response)
        XCTAssertNotNil(cookies)
    }

    func test_cookiesFromResponse_withResponse_withoutCookies() {
        let dataTask = TestsNSURLSessionDataTask()
        let response = TestsNSHTTPURLResponse()
        response.headerFieldsToUse = [2 : "Y"]
        dataTask.responseToUse = response
        let cookies = self.cookieManager.cookiesFromResponse(fromResponse: dataTask.response)
        XCTAssertNotNil(cookies)
    }

}
