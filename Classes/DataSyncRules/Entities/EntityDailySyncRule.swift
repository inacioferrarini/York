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

open class EntityDailySyncRule: EntityBaseSyncRules {

    open class func fetchEntityDailySyncRuleByName(_ name: String, inManagedObjectContext context: NSManagedObjectContext) -> EntityDailySyncRule? {

        guard name.characters.count > 0 else {
            return nil
        }

        let request: NSFetchRequest = NSFetchRequest<EntityDailySyncRule>(entityName: self.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)

        return self.lastObjectFromRequest(request, inManagedObjectContext: context)
    }

    open class func entityDailySyncRuleByName(_ name: String, days: NSNumber?, inManagedObjectContext context: NSManagedObjectContext) -> EntityDailySyncRule? {

        guard name.characters.count > 0 else {
            return nil
        }

        var entityDailySyncRule: EntityDailySyncRule? = fetchEntityDailySyncRuleByName(name, inManagedObjectContext: context)
        if entityDailySyncRule == nil {
            let newEntityDailySyncRule = NSEntityDescription.insertNewObject(forEntityName: self.simpleClassName(), into: context) as? EntityDailySyncRule
            if let entity = newEntityDailySyncRule {
                entity.name = name
            }
            entityDailySyncRule = newEntityDailySyncRule
        }

        if let entityDailySyncRule = entityDailySyncRule {
            entityDailySyncRule.days = days
        }

        return entityDailySyncRule
    }

    override open func shouldRunSyncRuleWithName(_ name: String, date: Date, inManagedObjectContext context: NSManagedObjectContext) -> Bool {
        let lastExecution = EntitySyncHistory.fetchEntityAutoSyncHistoryByName(name, inManagedObjectContext: context)
        if let lastExecution = lastExecution,
            let lastExecutionDate = lastExecution.lastExecutionDate,
            let days = self.days {
                let elapsedTime = Date().timeIntervalSince(lastExecutionDate)
                let targetTime = TimeInterval(days.int32Value * 24 * 60 * 60)
                return elapsedTime >= targetTime
        }
        return true
    }

}
