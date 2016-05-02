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

class EntityHourlySyncRuleTests: XCTestCase {


    // MARK: - Tests

    func test_fetchEntityHourlySyncRule_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let hourlySincRule = EntityHourlySyncRule.fetchEntityHourlySyncRuleByName("", inManagedObjectContext: context)
        XCTAssertNil(hourlySincRule)
    }

    func test_fetchEntityHourlySyncRule_withName_mustReturnEntity() {
        let ruleName = TestUtil().randomString()
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        if let _ = EntityHourlySyncRule.entityHourlySyncRuleByName(ruleName, hours: nil, inManagedObjectContext:context) {
            let fetchedRule = EntityHourlySyncRule.fetchEntityHourlySyncRuleByName(ruleName, inManagedObjectContext: context)
            XCTAssertNotNil(fetchedRule)
        }
    }

    func test_entityHourlySyncRule_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        coreDataStack.saveContext()
        let context = coreDataStack.managedObjectContext
        let hourlySincRule = EntityHourlySyncRule.entityHourlySyncRuleByName("", hours: nil, inManagedObjectContext: context)
        XCTAssertNil(hourlySincRule)
    }

    func test_shouldRunSyncRule_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let ruleName = TestUtil().randomString()
        if let rule = EntityHourlySyncRule.entityHourlySyncRuleByName(ruleName, hours: nil, inManagedObjectContext:context) {
            let shouldExecuteRule = rule.shouldRunSyncRuleWithName("", date: NSDate(), inManagedObjectContext: context)
            XCTAssertTrue(shouldExecuteRule)
        }
    }

}
