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

import XCTest
import York

class DataSyncDailyRulesTests: XCTestCase {


    // MARK: - Supporting Methods

    func createRules() -> DataSyncRules {
        let coreDataStack = TestUtil().appContext().coreDataStack
        return DataSyncRules(coreDataStack: coreDataStack)
    }


    // MARK: - Tests

    func test_nonExistingDailyRule_mustReturnFalse() {
        let ruleName = TestUtil().randomString()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Daily(3))
        let result = rules.shouldPerformSyncRule("NonExistingRule", atDate: NSDate())
        XCTAssertEqual(result, false, "Execution of a non-existing daily rule is expected to fail.")
    }

    func test_nonExistingDailyRule_update_doesNotcrash() {
        let ruleName = TestUtil().randomString()
        let rules = self.createRules()
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }

    func test_existingDailyRuleHistory_update_doesNotcrash() {
        let ruleName = TestUtil().randomString()
        let rules = self.createRules()
        let context = rules.coreDataStack.managedObjectContext
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName, lastExecutionDate: NSDate(), inManagedObjectContext: context)
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }

    func test_updatingExistingDailyRule_doesNotCrash() {
        let ruleName = TestUtil().randomString()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Daily(12))
        rules.updateSyncRuleHistoryExecutionTime(ruleName, lastExecutionDate: NSDate())
    }

    func test_existingDailyRuleWithoutLastExecutionDate_mustReturnTrue() {
        let ruleName = TestUtil().randomString()
        let rules = self.createRules()
        rules.addSyncRule(ruleName, rule: SyncRule.Daily(3))
        let result = rules.shouldPerformSyncRule(ruleName, atDate: NSDate())
        XCTAssertEqual(result, true, "Execution of an existing daily rule without last execution date is exected to succeeded.")
    }

    func test_existingDailyRule_withDaysEquals3AndlastExecutionDateEquals3_mustReturnTrue() {
        let ruleName = TestUtil().randomString()
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
        let ruleName = TestUtil().randomString()
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
