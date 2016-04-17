import XCTest
import York

class EntitySyncHistoryTests: XCTestCase {
    
    func test_fetchEntityAutoSyncHistory_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let sincHistory = EntitySyncHistory.fetchEntityAutoSyncHistoryByName("", inManagedObjectContext: context)
        XCTAssertNil(sincHistory)
    }
    
    func test_newEntityAutoSyncHistory_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let sincHistory = EntitySyncHistory.entityAutoSyncHistoryByName("", lastExecutionDate: nil, inManagedObjectContext: context)
        XCTAssertNil(sincHistory)
    }
 
    func test_removeAll_withoutEntities_mustNotCrash() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        EntitySyncHistory.removeAll(inManagedObjectContext: context)
    }

    func test_removeAll_withEntities_mustNotCrash() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let ruleName = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName, lastExecutionDate: nil, inManagedObjectContext: context)
        coreDataStack.saveContext()
        EntitySyncHistory.removeAll(inManagedObjectContext: context)
        coreDataStack.saveContext()
    }
    
}
