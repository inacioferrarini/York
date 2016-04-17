import Foundation
import CoreData

public class EntityDailySyncRule: EntityBaseSyncRules {

    public class func fetchEntityDailySyncRuleByName(name: String, inManagedObjectContext context:NSManagedObjectContext) -> EntityDailySyncRule? {
        
        guard name.characters.count > 0 else {
            return nil
        }
        
        let request:NSFetchRequest = NSFetchRequest(entityName: self.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)
        
        let matches = (try! context.executeFetchRequest(request)) as! [EntityDailySyncRule]
        if (matches.count > 0) {
            return matches.last
        }
        
        return nil
    }
    
    public class func entityDailySyncRuleByName(name:String, days: NSNumber?, inManagedObjectContext context:NSManagedObjectContext) -> EntityDailySyncRule? {
        
        guard name.characters.count > 0 else {
            return nil
        }
        
        var entityDailySyncRule:EntityDailySyncRule? = fetchEntityDailySyncRuleByName(name, inManagedObjectContext: context)
        if entityDailySyncRule == nil {
            let newEntityDailySyncRule = NSEntityDescription.insertNewObjectForEntityForName(self.simpleClassName(), inManagedObjectContext: context) as! EntityDailySyncRule
            newEntityDailySyncRule.name = name
            entityDailySyncRule = newEntityDailySyncRule
        }
        
        if let entityDailySyncRule = entityDailySyncRule {
            entityDailySyncRule.days = days
        }
        
        return entityDailySyncRule
    }
    
    override public func shouldRunSyncRuleWithName(name:String, date:NSDate, inManagedObjectContext context:NSManagedObjectContext) -> Bool {
        let lastExecution = EntitySyncHistory.fetchEntityAutoSyncHistoryByName(name, inManagedObjectContext: context)
        if let lastExecution = lastExecution,
            let lastExecutionDate = lastExecution.lastExecutionDate,
            let days = self.days {
                let elapsedTime = NSDate().timeIntervalSinceDate(lastExecutionDate)
                let targetTime = NSTimeInterval(days.intValue * 24 * 60 * 60)
                return elapsedTime >= targetTime
        }
        return true
    }

}
