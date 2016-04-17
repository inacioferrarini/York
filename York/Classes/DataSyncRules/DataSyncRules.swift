import UIKit

public enum SyncRule {
    case Hourly(Int)
    case Daily(Int)
}

public class DataSyncRules: NSObject {
    
    // MARK: - Properties
    
    public let coreDataStack: CoreDataStack
    
    
    // MARK: - Initialization
    
    public init(coreDataStack: CoreDataStack) {    // rules: [String, SyncRule]
        self.coreDataStack = coreDataStack
        super.init()
    }
    
    
    // MARK: - Public Methods
    
    public func addSyncRule(ruleName: String, rule: SyncRule) {
        let context = self.coreDataStack.managedObjectContext
        switch rule {
        case let .Hourly(hours):
            EntityHourlySyncRule.entityHourlySyncRuleByName(ruleName, hours: hours, inManagedObjectContext: context)
        case let .Daily(days):
            EntityDailySyncRule.entityDailySyncRuleByName(ruleName, days: days, inManagedObjectContext: context)
        }
        self.coreDataStack.saveContext()
    }
    
    public func shouldPerformSyncRule(ruleName: String, atDate date:NSDate) -> Bool {
        let context = self.coreDataStack.managedObjectContext
        if let rule = EntityBaseSyncRules.fetchEntityBaseSyncRulesByName(ruleName, inManagedObjectContext: context) {
            return rule.shouldRunSyncRuleWithName(ruleName, date: date, inManagedObjectContext: context)
        }
        
        return false
    }
    
    public func updateSyncRuleHistoryExecutionTime(ruleName: String, lastExecutionDate: NSDate) {
        let context = self.coreDataStack.managedObjectContext
        if let rule = EntitySyncHistory.fetchEntityAutoSyncHistoryByName(ruleName, inManagedObjectContext: context) {
            rule.lastExecutionDate = lastExecutionDate
        } else {
            EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
                lastExecutionDate: lastExecutionDate, inManagedObjectContext: context)
        }
    }
    
}
