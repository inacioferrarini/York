import XCTest
import York

class EntityHourlySyncRuleTests: XCTestCase {

    func test_fetchEntityHourlySyncRule_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let hourlySincRule = EntityHourlySyncRule.fetchEntityHourlySyncRuleByName("", inManagedObjectContext: context)
        XCTAssertNil(hourlySincRule)
    }
    
    func test_fetchEntityHourlySyncRule_withName_mustReturnEntity() {
        let ruleName = TestUtil().randomRuleName()
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        if let _ = EntityHourlySyncRule.entityHourlySyncRuleByName(ruleName, hours: nil, inManagedObjectContext:context) {
            let fetchedRule = EntityHourlySyncRule.fetchEntityHourlySyncRuleByName(ruleName, inManagedObjectContext: context)
            XCTAssertNotNil(fetchedRule)
        }
    }
    
    func test_entityHourlySyncRule_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        coreDataStack.saveContext()
        let context = coreDataStack.managedObjectContext
        let hourlySincRule = EntityHourlySyncRule.entityHourlySyncRuleByName("", hours: nil, inManagedObjectContext: context)
        XCTAssertNil(hourlySincRule)
    }
    
    func test_shouldRunSyncRule_withEmptyName_mustReturnNil() {
        let coreDataStack = TestUtil().appContext().coreDataStack
        let context = coreDataStack.managedObjectContext
        let ruleName = TestUtil().randomRuleName()
        if let rule = EntityHourlySyncRule.entityHourlySyncRuleByName(ruleName, hours: nil, inManagedObjectContext:context) {
            let shouldExecuteRule = rule.shouldRunSyncRuleWithName("", date: NSDate(), inManagedObjectContext: context)
            XCTAssertTrue(shouldExecuteRule)
        }
    }
    
}
