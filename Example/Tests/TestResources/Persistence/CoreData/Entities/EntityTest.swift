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

import Foundation
import CoreData
import York

open class EntityTest: NSManagedObject {

    open class func fetchAll(inManagedObjectContext context: NSManagedObjectContext, usingSortDescriptor sortDescriptors: [NSSortDescriptor]?) -> [EntityTest]? {
        let request: NSFetchRequest = NSFetchRequest<EntityTest>(entityName: self.simpleClassName())
        request.sortDescriptors = sortDescriptors
        return self.allObjectsFromRequest(request, inManagedObjectContext: context)
    }

    open class func fetchEntityTest(_ sectionName: String?, name: String?, inManagedObjectContext context: NSManagedObjectContext) -> EntityTest? {
        var predicates = [NSPredicate]()

        if let sectionName = sectionName, sectionName.characters.count > 0 {
            predicates.append(NSPredicate(format: "sectionName = %@", sectionName))
        }

        if let name = name, name.characters.count > 0 {
            predicates.append(NSPredicate(format: "name = %@", name))
        }

        guard predicates.count > 0 else {
            return nil
        }

        let request: NSFetchRequest = NSFetchRequest<EntityTest>(entityName: self.simpleClassName())
        if predicates.count > 1 {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        } else {
            request.predicate = predicates.last
        }

        return self.lastObjectFromRequest(request, inManagedObjectContext: context)
    }

    open class func entityTest(_ sectionName: String?, name: String?, order: Int?, inManagedObjectContext context: NSManagedObjectContext) -> EntityTest? {

        var entityTest: EntityTest? = self.fetchEntityTest(sectionName, name: name, inManagedObjectContext: context)
        if entityTest == nil {
            let newEntityTest = NSEntityDescription.insertNewObject(forEntityName: self.simpleClassName(), into: context) as? EntityTest
            if let entity = newEntityTest {
                entity.sectionName = sectionName
                entity.name = name
                entity.order = order as NSNumber?
            }
            entityTest = newEntityTest
        }
        return entityTest
    }

    open class func removeAll(inManagedObjectContext context: NSManagedObjectContext) {
        if let allEntities = self.fetchAll(inManagedObjectContext: context, usingSortDescriptor: nil) {
            for entity in allEntities {
                context.delete(entity)
            }
        }
    }

}
