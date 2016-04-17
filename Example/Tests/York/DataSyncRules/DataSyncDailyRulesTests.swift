import XCTest
import York

class DataSyncDailyRulesTests: XCTestCase {
    
    func createRules() -> DataSyncRules {
        let coreDataStack = TestUtil().appContext().coreDataStack
        return DataSyncRules(coreDataStack: coreDataStack)
    }
    
    func test_nonExistingDailyRule_mustReturnFalse() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Daily(3))
        let result = rules.shouldPerformSyncRule("NonExistingRule", atDate: NSDate())
        XCTAssertEqual(result, false, "Execution of a non-existing daily rule is expected to fail.")
    }
    
    func test_nonExistingDailyRule_update_doesNotcrash() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }

    func test_existingDailyRuleHistory_update_doesNotcrash() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        let context = rules.coreDataStack.managedObjectContext
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName, lastExecutionDate: NSDate(), inManagedObjectContext: context)
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }
    
    func test_updatingExistingDailyRule_doesNotCrash() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Daily(12))
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }
    
    func test_existingDailyRuleWithoutLastExecutionDate_mustReturnTrue() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Daily(3))
        let result = rules.shouldPerformSyncRule(ruleName, atDate: NSDate())
        XCTAssertEqual(result, true, "Execution of an existing daily rule without last execution date is exected to succeeded.")
    }
    
    func test_existingDailyRule_withDaysEquals3AndlastExecutionDateEquals3_mustReturnTrue() {
        let ruleName = TestUtil().randomRuleName()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let lastExecutionDate = formatter.dateFromString("2015-03-23T12:20:20")!
        let executionDate = formatter.dateFromString("2015-03-26T12:20:20")!
        
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Daily(3))
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: lastExecutionDate)
        let result = rules.shouldPerformSyncRule(ruleName, atDate: executionDate)
        
        XCTAssertEqual(result, true)
    }
    
    func test_existingDailyRule_withDaysEqual32AndlastExecutionDateEquals2_mustReturnFalse() {
        let ruleName = TestUtil().randomRuleName()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let lastExecutionDate = formatter.dateFromString("2015-03-23T12:20:20")!
        let executionDate = formatter.dateFromString("2015-03-25T12:20:20")!
        
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Daily(3))
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: lastExecutionDate)
        let result = rules.shouldPerformSyncRule(ruleName, atDate: executionDate)
        
        XCTAssertEqual(result, true)
    }

}
