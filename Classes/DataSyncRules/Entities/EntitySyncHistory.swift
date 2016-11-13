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

open class EntitySyncHistory: NSManagedObject {

    open class func fetchAllEntitiesAutoSyncHistory(inManagedObjectContext context: NSManagedObjectContext) -> [EntitySyncHistory]? {
        let request: NSFetchRequest = NSFetchRequest<EntitySyncHistory>(entityName: self.simpleClassName())

        return self.allObjectsFromRequest(request, inManagedObjectContext: context)
    }

    open class func fetchEntityAutoSyncHistoryByName(_ name: String, inManagedObjectContext context: NSManagedObjectContext) -> EntitySyncHistory? {

        guard name.characters.count > 0 else {
            return nil
        }

        let request: NSFetchRequest = NSFetchRequest<EntitySyncHistory>(entityName: self.simpleClassName())
        request.predicate = NSPredicate(format: "ruleName = %@", name)

        return self.lastObjectFromRequest(request, inManagedObjectContext: context)
    }

    open class func entityAutoSyncHistoryByName(_ name: String, lastExecutionDate: Date?, inManagedObjectContext context: NSManagedObjectContext) -> EntitySyncHistory? {

        guard name.characters.count > 0 else {
            return nil
        }

        var entityAutoSyncHistory: EntitySyncHistory? = fetchEntityAutoSyncHistoryByName(name, inManagedObjectContext: context)
        if entityAutoSyncHistory == nil {
            let newEntityAutoSyncHistory = NSEntityDescription.insertNewObject(forEntityName: self.simpleClassName(), into: context) as? EntitySyncHistory
            if let entity = newEntityAutoSyncHistory {
                entity.ruleName = name
            }
            entityAutoSyncHistory = newEntityAutoSyncHistory
        }

        if let entityAutoSyncHistory = entityAutoSyncHistory {
            entityAutoSyncHistory.lastExecutionDate = lastExecutionDate
        }

        return entityAutoSyncHistory
    }

    open class func removeAll(inManagedObjectContext context: NSManagedObjectContext) {
        if let allEntities = self.fetchAllEntitiesAutoSyncHistory(inManagedObjectContext: context) {
            for entity in allEntities {
                context.delete(entity)
            }
        }
    }

}
