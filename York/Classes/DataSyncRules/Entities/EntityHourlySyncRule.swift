import Foundation
import CoreData

public class EntityHourlySyncRule: EntityBaseSyncRules {
    
    public class func fetchEntityHourlySyncRuleByName(name: String, inManagedObjectContext context:NSManagedObjectContext) -> EntityHourlySyncRule? {
        
        guard name.characters.count > 0 else {
            return nil
        }
        
        let request:NSFetchRequest = NSFetchRequest(entityName: self.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)
        
        let matches = (try! context.executeFetchRequest(request)) as! [EntityHourlySyncRule]
        if (matches.count > 0) {
            return matches.last
        }
        
        return nil
    }
    
    public class func entityHourlySyncRuleByName(name:String, hours: NSNumber?, inManagedObjectContext context:NSManagedObjectContext) -> EntityHourlySyncRule? {
        
        guard name.characters.count > 0 else {
            return nil
        }
        
        var entityHourlySyncRule:EntityHourlySyncRule? = fetchEntityHourlySyncRuleByName(name, inManagedObjectContext: context)
        if entityHourlySyncRule == nil {
            let newEntityHourlySyncRule = NSEntityDescription.insertNewObjectForEntityForName(self.simpleClassName(), inManagedObjectContext: context) as! EntityHourlySyncRule
            newEntityHourlySyncRule.name = name
            entityHourlySyncRule = newEntityHourlySyncRule
        }
        
        if let entityHourlySyncRule = entityHourlySyncRule {
            entityHourlySyncRule.hours = hours
        }
        
        return entityHourlySyncRule
    }
    
    override public func shouldRunSyncRuleWithName(name:String, date:NSDate, inManagedObjectContext context:NSManagedObjectContext) -> Bool {
        let lastExecution = EntitySyncHistory.fetchEntityAutoSyncHistoryByName(name, inManagedObjectContext: context)
        if let lastExecution = lastExecution,
            let lastExecutionDate = lastExecution.lastExecutionDate,
            let hours = self.hours {
                let elapsedTime = NSDate().timeIntervalSinceDate(lastExecutionDate)
                let targetTime = NSTimeInterval(hours.intValue * 60 * 60)
                return elapsedTime >= targetTime
        }
        return true
    }
    
}
