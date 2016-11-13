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

public enum SyncRule {
    case hourly(NSNumber)
    case daily(NSNumber)
}

open class DataSyncRules: NSObject {

    // MARK: - Properties

    open let coreDataStack: CoreDataStack


    // MARK: - Initialization

    public init(coreDataStack: CoreDataStack) {    // rules: [String, SyncRule]
        self.coreDataStack = coreDataStack
        super.init()
    }


    // MARK: - Public Methods

    open func addSyncRule(_ ruleName: String, rule: SyncRule) {
        let context = self.coreDataStack.managedObjectContext
        switch rule {
        case let .hourly(hours):
            _ = EntityHourlySyncRule.entityHourlySyncRuleByName(ruleName, hours: hours, inManagedObjectContext: context)
        case let .daily(days):
            _ = EntityDailySyncRule.entityDailySyncRuleByName(ruleName, days: days, inManagedObjectContext: context)
        }
        self.coreDataStack.saveContext()
    }

    open func shouldPerformSyncRule(_ ruleName: String, atDate date: Date) -> Bool {
        let context = self.coreDataStack.managedObjectContext
        if let rule = EntityBaseSyncRules.fetchEntityBaseSyncRulesByName(ruleName, inManagedObjectContext: context) {
            return rule.shouldRunSyncRuleWithName(ruleName, date: date, inManagedObjectContext: context)
        }

        return false
    }

    open func updateSyncRuleHistoryExecutionTime(_ ruleName: String, lastExecutionDate: Date) {
        let context = self.coreDataStack.managedObjectContext
        if let rule = EntitySyncHistory.fetchEntityAutoSyncHistoryByName(ruleName, inManagedObjectContext: context) {
            rule.lastExecutionDate = lastExecutionDate
        } else {
            _ = EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
                lastExecutionDate: lastExecutionDate, inManagedObjectContext: context)
        }
    }

}
