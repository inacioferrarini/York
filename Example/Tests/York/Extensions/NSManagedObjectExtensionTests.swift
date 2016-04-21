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
import CoreData
import York

class NSManagedObjectExtensionTests: XCTestCase {

    func test_lastObjectFromRequest_mustReturnObject() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let historyName = "rule-test-name"
        EntitySyncHistory.removeAll(inManagedObjectContext: context)
        EntitySyncHistory.entityAutoSyncHistoryByName(historyName,
            lastExecutionDate: nil,
            inManagedObjectContext: context)
        coreDataStack.saveContext()

        let request: NSFetchRequest = NSFetchRequest(entityName: EntitySyncHistory.simpleClassName())
        request.predicate = NSPredicate(format: "ruleName = %@", historyName)

        let object = EntitySyncHistory.lastObjectFromRequest(request, inManagedObjectContext: context)
        XCTAssertNotNil(object)
    }

    func test_lastObjectFromRequest_mustNotThrow() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let name = "unkown"
        let request: NSFetchRequest = NSFetchRequest(entityName: EntitySyncHistory.simpleClassName())
        request.predicate = NSPredicate(format: "ruleName = %@", name)

        let object = EntitySyncHistory.lastObjectFromRequest(request, inManagedObjectContext: context)
        XCTAssertNil(object)
    }

    func test_lastObjectFromRequest_mustThrow() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let name = "unkown"
        let request: NSFetchRequest = NSFetchRequest(entityName: EntitySyncHistory.simpleClassName())
        request.predicate = NSPredicate(format: "nonExistingRuleName = %@", name)

        let object = EntitySyncHistory.lastObjectFromRequest(request, inManagedObjectContext: context)
        XCTAssertNil(object)
    }



    func test_allObjectsFromRequest_mustReturnObjects() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        
        let historyName = "rule-test-name"
        EntitySyncHistory.removeAll(inManagedObjectContext: context)
        EntitySyncHistory.entityAutoSyncHistoryByName(historyName,
            lastExecutionDate: nil,
            inManagedObjectContext: context)
        coreDataStack.saveContext()
        
        let request: NSFetchRequest = NSFetchRequest(entityName: EntitySyncHistory.simpleClassName())
        request.predicate = NSPredicate(format: "ruleName = %@", historyName)
        
        let objects = EntitySyncHistory.allObjectsFromRequest(request, inManagedObjectContext: context)
        XCTAssertEqual(objects.count, 1)
    }

    func test_allObjectsFromRequest_mustNotThrow() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let name = "unkown"
        let request: NSFetchRequest = NSFetchRequest(entityName: EntitySyncHistory.simpleClassName())
        request.predicate = NSPredicate(format: "ruleName = %@", name)

        let objects = EntitySyncHistory.allObjectsFromRequest(request, inManagedObjectContext: context)
        XCTAssertEqual(objects.count, 0)
    }

    func test_allObjectsFromRequest_mustThrow() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let number = NSNumber(int: 20)
        let request: NSFetchRequest = NSFetchRequest(entityName: EntitySyncHistory.simpleClassName())
        request.predicate = NSPredicate(format: "ruleName = %@", number)

        let objects = EntitySyncHistory.allObjectsFromRequest(request, inManagedObjectContext: context)
        XCTAssertEqual(objects.count, 0)
    }

}