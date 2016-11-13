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

open class EntityHourlySyncRule: EntityBaseSyncRules {

    open class func fetchEntityHourlySyncRuleByName(_ name: String, inManagedObjectContext context: NSManagedObjectContext) -> EntityHourlySyncRule? {

        guard name.characters.count > 0 else {
            return nil
        }

        let request: NSFetchRequest = NSFetchRequest<EntityHourlySyncRule>(entityName: self.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)

        return self.lastObjectFromRequest(request, inManagedObjectContext: context)
    }

    open class func entityHourlySyncRuleByName(_ name: String, hours: NSNumber?, inManagedObjectContext context: NSManagedObjectContext) -> EntityHourlySyncRule? {

        guard name.characters.count > 0 else {
            return nil
        }

        var entityHourlySyncRule: EntityHourlySyncRule? = fetchEntityHourlySyncRuleByName(name, inManagedObjectContext: context)
        if entityHourlySyncRule == nil {
            let newEntityHourlySyncRule = NSEntityDescription.insertNewObject(forEntityName: self.simpleClassName(), into: context) as? EntityHourlySyncRule
            if let entity = newEntityHourlySyncRule {
                entity.name = name
            }
            entityHourlySyncRule = newEntityHourlySyncRule
        }

        if let entityHourlySyncRule = entityHourlySyncRule {
            entityHourlySyncRule.hours = hours
        }

        return entityHourlySyncRule
    }

    override open func shouldRunSyncRuleWithName(_ name: String, date: Date, inManagedObjectContext context: NSManagedObjectContext) -> Bool {
        let lastExecution = EntitySyncHistory.fetchEntityAutoSyncHistoryByName(name, inManagedObjectContext: context)
        if let lastExecution = lastExecution,
            let lastExecutionDate = lastExecution.lastExecutionDate,
            let hours = self.hours {
                let elapsedTime = Date().timeIntervalSince(lastExecutionDate)
                let targetTime = TimeInterval(hours.int32Value * 60 * 60)
                return elapsedTime >= targetTime
        }
        return true
    }

}
