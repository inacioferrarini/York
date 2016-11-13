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


    // MARK: - Tests

    func test_lastObjectFromRequest_mustReturnObject() {
        let coreDataStack = TestUtil().testAppContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let name = "test-name"
        EntityTest.removeAll(inManagedObjectContext: context)
        _ = EntityTest.entityTest(nil, name: name, order: nil, inManagedObjectContext: context)
        coreDataStack.saveContext()

        let request: NSFetchRequest<EntityTest> = NSFetchRequest<EntityTest>(entityName: EntityTest.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)

        let entity = EntityTest.lastObjectFromRequest(request, inManagedObjectContext: context)
        XCTAssertNotNil(entity)
    }

    func test_lastObjectFromRequest_mustNotThrow() {
        let coreDataStack = TestUtil().testAppContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let name = "unkown"
        let request: NSFetchRequest<EntityTest> = NSFetchRequest<EntityTest>(entityName: EntityTest.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)

        let entity = EntityTest.lastObjectFromRequest(request, inManagedObjectContext: context)
        XCTAssertNil(entity)
    }

    func test_lastObjectFromRequest_mustThrow() {
        let coreDataStack = TestUtil().testAppContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let name = "unkown"
        let request: NSFetchRequest<EntityTest> = NSFetchRequest<EntityTest>(entityName: EntityTest.simpleClassName())
        request.predicate = NSPredicate(format: "nonExistingName = %@", name)

        let entity = EntityTest.lastObjectFromRequest(request, inManagedObjectContext: context)
        XCTAssertNil(entity)
    }



    func test_allObjectsFromRequest_mustReturnObjects() {
        let coreDataStack = TestUtil().testAppContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let name = "test-name"
        EntityTest.removeAll(inManagedObjectContext: context)
        _ = EntityTest.entityTest(nil, name: name, order: nil, inManagedObjectContext: context)
        coreDataStack.saveContext()

        let request: NSFetchRequest<EntityTest> = NSFetchRequest<EntityTest>(entityName: EntityTest.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)

        let entities = EntityTest.allObjectsFromRequest(request, inManagedObjectContext: context)
        XCTAssertEqual(entities.count, 1)
    }

    func test_allObjectsFromRequest_mustNotThrow() {
        let coreDataStack = TestUtil().testAppContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let name = "unkown"
        let request: NSFetchRequest<EntityTest> = NSFetchRequest<EntityTest>(entityName: EntityTest.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)

        let entities = EntityTest.allObjectsFromRequest(request, inManagedObjectContext: context)
        XCTAssertEqual(entities.count, 0)
    }

    func test_allObjectsFromRequest_mustThrow() {
        let coreDataStack = TestUtil().testAppContext().coreDataStack
        let context = coreDataStack.managedObjectContext

        let number = NSNumber(value: 20 as Int32)
        let request: NSFetchRequest<EntityTest> = NSFetchRequest<EntityTest>(entityName: EntityTest.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", number)

        let entities = EntityTest.allObjectsFromRequest(request, inManagedObjectContext: context)
        XCTAssertEqual(entities.count, 0)
    }

}
