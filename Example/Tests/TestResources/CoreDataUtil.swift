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
import York
import CoreData

public class CoreDataUtil: NSObject {

    private let context: NSManagedObjectContext

    // MARK: - Initialization

    public init(inManagedObjectContext context: NSManagedObjectContext) {
        self.context = context
        super.init()
    }


    // MARK: - Core Data Supporting Methods

    public func removeAllTestEntities() {
        EntityTest.removeAll(inManagedObjectContext: self.context)
    }

    public func removeTestEntity(entity: EntityTest) {
        self.context.deleteObject(entity)
    }

    public func removeTestEntitiesFromArray(entities: [EntityTest]?) {
        if let allEntities = entities {
            for entity in allEntities {
                self.removeTestEntity(entity)
            }
        }
    }

    public func createTestEntity(sectionName: String?, name: String?, order: Int?) -> EntityTest? {
        return EntityTest.entityTest(sectionName, name: name, order: order, inManagedObjectContext: self.context)
    }

    public func createTestMass(withSize size: Int, usingInitialIndex initialIndex: Int, inSection section: Int, initialOrderValue initialOrder: Int) -> [EntityTest] {
        var entities = [EntityTest]()
        for k in 1...size {
            let delta = k - 1
            let currentIndex = initialIndex + delta
            let order = initialOrder + delta
            let sectionName = "section\(section)"
            let name = "s\(section)-e\(currentIndex)"

            if let entity = self.createTestEntity(sectionName, name: name, order: order) {
                entities.append(entity)
            }
        }
        return entities
    }

}
