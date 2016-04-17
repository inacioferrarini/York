import XCTest
import York

class EntityDailySyncRuleTests: XCTestCase {

//    func test_fetchEntityDailySyncRule_withEmptyName_mustReturnNil() {
//        let coreDataStack = TestUtil().appContext().coreDataStack
//        let context = coreDataStack.managedObjectContext
//        let dailySincRule = EntityDailySyncRule.fetchEntityDailySyncRuleByName("", inManagedObjectContext: context)
//        XCTAssertNil(dailySincRule)
//    }

//    func test_fetchEntityDailySyncRule_withName_mustReturnEntity() {
//        let ruleName = TestUtil().randomRuleName()
//        let coreDataStack = TestUtil().appContext().coreDataStack
//        let context = coreDataStack.managedObjectContext
//        if let _ = EntityDailySyncRule.entityDailySyncRuleByName(ruleName, days: nil, inManagedObjectContext:context) {
//            let fetchedRule = EntityDailySyncRule.fetchEntityDailySyncRuleByName(ruleName, inManagedObjectContext: context)
//            XCTAssertNotNil(fetchedRule)
//        }
//    }
    
//    func test_entityDailySyncRule_withEmptyName_mustReturnNil() {
//        let coreDataStack = TestUtil().appContext().coreDataStack
//        let context = coreDataStack.managedObjectContext
//        let dailySincRule = EntityDailySyncRule.entityDailySyncRuleByName("", days: 0, inManagedObjectContext: context)
//        XCTAssertNil(dailySincRule)
//    }

//    func test_shouldRunSyncRule_withEmptyName_mustReturnNil() {
//        let coreDataStack = TestUtil().appContext().coreDataStack
//        let context = coreDataStack.managedObjectContext
//        let ruleName = TestUtil().randomRuleName()
//        if let rule = EntityDailySyncRule.entityDailySyncRuleByName(ruleName, days: nil, inManagedObjectContext:context) {
//            let shouldExecuteRule = rule.shouldRunSyncRuleWithName("", date: NSDate(), inManagedObjectContext: context)
//            XCTAssertTrue(shouldExecuteRule)
//        }
//    }

//    func test_shouldRunSyncRule_withNonExistingRuleName_mustReturnNil() {
//        let coreDataStack = TestUtil().appContext().coreDataStack
//        let context = coreDataStack.managedObjectContext
//        let ruleName2 = TestUtil().randomRuleName()
//        if let rule = EntityDailySyncRule.entityDailySyncRuleByName(ruleName2, days: nil, inManagedObjectContext:context) {
//            let shouldExecuteRule = rule.shouldRunSyncRuleWithName("", date: NSDate(), inManagedObjectContext: context)
//            XCTAssertTrue(shouldExecuteRule)
//        }
//    }
    
}
