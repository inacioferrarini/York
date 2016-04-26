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

class EntitySyncHistoryTests: XCTestCase {
    
    func test_fetchEntityAutoSyncHistory_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let sincHistory = EntitySyncHistory.fetchEntityAutoSyncHistoryByName("", inManagedObjectContext: context)
        XCTAssertNil(sincHistory)
    }
    
    func test_newEntityAutoSyncHistory_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let sincHistory = EntitySyncHistory.entityAutoSyncHistoryByName("", lastExecutionDate: nil, inManagedObjectContext: context)
        XCTAssertNil(sincHistory)
    }
 
    func test_removeAll_withoutEntities_mustNotCrash() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        EntitySyncHistory.removeAll(inManagedObjectContext: context)
    }

    func test_removeAll_withEntities_mustNotCrash() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let ruleName = TestUtil().randomString()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName, lastExecutionDate: nil, inManagedObjectContext: context)
        coreDataStack.saveContext()
        EntitySyncHistory.removeAll(inManagedObjectContext: context)
        coreDataStack.saveContext()
    }
    
}
