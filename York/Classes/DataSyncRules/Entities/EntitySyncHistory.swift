import Foundation
import CoreData

public class EntitySyncHistory: NSManagedObject {
    
    public class func fetchAllEntitiesAutoSyncHistory(inManagedObjectContext context:NSManagedObjectContext) -> [EntitySyncHistory] {
        let request:NSFetchRequest = NSFetchRequest(entityName: self.simpleClassName())
        return (try! context.executeFetchRequest(request)) as! [EntitySyncHistory]
    }
    
    public class func fetchEntityAutoSyncHistoryByName(name: String, inManagedObjectContext context:NSManagedObjectContext) -> EntitySyncHistory? {
        
        guard name.characters.count > 0 else {
            return nil
        }
        
        let request:NSFetchRequest = NSFetchRequest(entityName: self.simpleClassName())
        request.predicate = NSPredicate(format: "ruleName = %@", name)
        
        let matches = (try! context.executeFetchRequest(request)) as! [EntitySyncHistory]
        if (matches.count > 0) {
            return matches.last
        }
        
        return nil
    }
    
    public class func entityAutoSyncHistoryByName(name:String, lastExecutionDate: NSDate?, inManagedObjectContext context:NSManagedObjectContext) -> EntitySyncHistory? {
        
        guard name.characters.count > 0 else {
            return nil
        }
        
        var entityAutoSyncHistory:EntitySyncHistory? = fetchEntityAutoSyncHistoryByName(name, inManagedObjectContext: context)
        if entityAutoSyncHistory == nil {
            let newEntityAutoSyncHistory = NSEntityDescription.insertNewObjectForEntityForName(self.simpleClassName(), inManagedObjectContext: context) as! EntitySyncHistory
            newEntityAutoSyncHistory.ruleName = name
            entityAutoSyncHistory = newEntityAutoSyncHistory
        }
        
        if let entityAutoSyncHistory = entityAutoSyncHistory {
            entityAutoSyncHistory.lastExecutionDate = lastExecutionDate
        }
        
        return entityAutoSyncHistory
    }
    
    public class func removeAll(inManagedObjectContext context:NSManagedObjectContext) {
        let allEntities = self.fetchAllEntitiesAutoSyncHistory(inManagedObjectContext: context)
        for entity in allEntities {
            context.deleteObject(entity)
        }
    }
    
}
