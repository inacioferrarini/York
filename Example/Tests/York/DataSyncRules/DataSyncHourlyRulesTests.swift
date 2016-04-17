import XCTest
import York

class DataSyncHourlyRulesTests: XCTestCase {
    
    func createRules() -> DataSyncRules {
        let coreDataStack = TestUtil().appContext().coreDataStack
        return DataSyncRules(coreDataStack: coreDataStack)
    }
    
    func test_nonExistingHourlyRule_mustReturnFalse() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Hourly(12))
        let result = rules.shouldPerformSyncRule("NonExistingRule", atDate: NSDate())
        XCTAssertEqual(result, false, "Execution of a non-existing hourly rule is expected to fail.")
    }
    
    func test_nonExistingHourlyRule_update_doesNotcrash() {
        let ruleName = TestUtil().randomRuleName()        
        let rules = self.createRules()
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }

    func test_existingHourlyRuleHistory_update_doesNotcrash() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        let context = rules.coreDataStack.managedObjectContext
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName, lastExecutionDate: NSDate(), inManagedObjectContext: context)
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }
    
    func test_updatingExistingHourlyRule_doesNotCrash() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Hourly(12))
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }
    
    func test_existingHourlyRuleWithoutLastExecutionDate_mustReturnTrue() {
        let ruleName = TestUtil().randomRuleName()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Hourly(12))
        let result = rules.shouldPerformSyncRule(ruleName, atDate: NSDate())
        XCTAssertEqual(result, true, "Execution of an existing hourly rule without last execution date is exected to succeeded.")
    }
    
    func test_existingHourlyRule_withDaysEquals3AndlastExecutionDateEquals3_mustReturnTrue() {
        let ruleName = TestUtil().randomRuleName()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let lastExecutionDate = formatter.dateFromString("2015-03-23T01:20:20")!
        let executionDate = formatter.dateFromString("2015-03-26T12:20:20")!
        
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Hourly(12))
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: lastExecutionDate)
        let result = rules.shouldPerformSyncRule(ruleName, atDate: executionDate)
        
        XCTAssertEqual(result, true)
    }

    func test_existingHourlyRule_withDaysEqual32AndlastExecutionDateEquals2_mustReturnFalse() {
        let ruleName = TestUtil().randomRuleName()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let lastExecutionDate = formatter.dateFromString("2015-03-23T01:20:20")!
        let executionDate = formatter.dateFromString("2015-03-25T13:20:20")!
        
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Hourly(12))
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: lastExecutionDate)
        let result = rules.shouldPerformSyncRule(ruleName , atDate: executionDate)
        
        XCTAssertEqual(result, true)
    }
    
}
