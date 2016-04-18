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
import CoreData
import York

class FetcherDataSourceTests: XCTestCase {    
    
    var tableView:UITableView!
    var entityName: String!
    var predicate: NSPredicate?
    var fetchLimit: NSInteger?
    var sortDescriptors: [NSSortDescriptor]!
    var sectionNameKeyPath: String?
    var cacheName: String?
    var coreDataStack: CoreDataStack!
    var managedObjectContext:NSManagedObjectContext!
    var presenter:TableViewCellPresenter<UITableViewCell, EntitySyncHistory>!
    var logger:Logger!
    var configureCellBlockWasCalled:Bool = false
    
    
    func createFetcherDataSource(sectionNameKeyPath nameKeyPath: String?) -> FetcherDataSource<UITableViewCell, EntitySyncHistory> {
        let frame = CGRectMake(0, 0, 200, 200)
        let tableView = UITableView(frame: frame, style: .Plain)
        return self.createFetcherDataSource(sectionNameKeyPath: nameKeyPath, tableView: tableView)
    }
    
    func createFetcherDataSource(sectionNameKeyPath nameKeyPath: String?, tableView: UITableView!) -> FetcherDataSource<UITableViewCell, EntitySyncHistory> {
        self.tableView = tableView
        self.presenter = TableViewCellPresenter<UITableViewCell, EntitySyncHistory>(
            configureCellBlock: { (cell: UITableViewCell, entity:EntitySyncHistory) -> Void in
                self.configureCellBlockWasCalled = true
            }, cellReuseIdentifier: "TableViewCell")
        self.entityName = "EntitySyncHistory"
        self.sortDescriptors = []
        self.coreDataStack = TestUtil().appContext().coreDataStack
        self.managedObjectContext = self.coreDataStack.managedObjectContext
        self.logger = Logger()
        self.predicate = NSPredicate(format: "ruleName = %@", "rule01")
        self.fetchLimit = 100
        self.sectionNameKeyPath = nameKeyPath
        self.cacheName = "cacheName"
        
        let dataSource = FetcherDataSource(targetingTableView: self.tableView,
            presenter: self.presenter,
            entityName: self.entityName,
            sortDescriptors: self.sortDescriptors,
            managedObjectContext: self.managedObjectContext,
            logger: self.logger,
            predicate: self.predicate,
            fetchLimit: self.fetchLimit,
            sectionNameKeyPath: self.sectionNameKeyPath,
            cacheName: self.cacheName)
        dataSource.predicate = nil
        return dataSource
    }
        
    func test_refresh_mustSucceed() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = []
        dataSource.refreshData()
    }

    
    func test_refresh_mustIgnoreExceptionCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "nonExistingField", ascending: true) ]
        dataSource.refreshData()
    }
    
    
    func test_objectAtIndexPath_mustReturnEntity() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        EntitySyncHistory.entityAutoSyncHistoryByName("rule-test-name",
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        self.coreDataStack.saveContext()
        dataSource.refreshData()
        // let indexPath = dataSource.indexPathForObject(entity!)
        let object = dataSource.objectAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertNotNil(object)
    }
    
    
    func test_indexPathForObject_mustReturnObject() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        let entity = EntitySyncHistory.entityAutoSyncHistoryByName("rule-test-name",
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        self.coreDataStack.saveContext()
        dataSource.refreshData()
        let indexPath = dataSource.indexPathForObject(entity!)
        XCTAssertNotNil(indexPath)
    }
    
    func test_indexPathForObject_mustReturnNil() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        let entity = EntitySyncHistory.entityAutoSyncHistoryByName("rule-test-name",
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        self.coreDataStack.saveContext()
        dataSource.refreshData()
        let indexPath = dataSource.indexPathForObject(entity!)
        XCTAssertNotNil(indexPath)
    }
    
    
    func test_numberOfSections_mustReturnZero() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: "ruleName")
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        self.coreDataStack.saveContext()
        let numberOfSections = dataSource.numberOfSectionsInTableView(self.tableView)
        XCTAssertEqual(numberOfSections, 0)
    }

    
    func test_numberOfRowsInSection_mustReturnZero() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        let numberOfRows = dataSource.tableView(self.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_numberOfRowsInSection_mustReturnNonZero() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        EntitySyncHistory.entityAutoSyncHistoryByName("rule-test-name",
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        dataSource.refreshData()
        let numberOfRows = dataSource.tableView(self.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func test_cellForRowAtIndexPath_mustReturnCell() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = dataSource
        
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        let ruleName = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        self.coreDataStack.saveContext()
        dataSource.refreshData()
        tableView.reloadData()
        
        let cell = dataSource.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertNotNil(cell)
    }

    
    func test_canEditRowAtIndexPath_withBlock_mustSucceed() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> Bool in
            return true
        }
        let canEdit = dataSource.tableView(self.tableView, canEditRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertTrue(canEdit)
    }
    
    func test_canEditRowAtIndexPath_withoutBlock_mustFail() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = nil
        let canEdit = dataSource.tableView(self.tableView, canEditRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertFalse(canEdit)
    }
    
    
    func test_commitEditingStyle_withBlock_mustExecuteBlock() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        var executedCommitEditingStyleBlock = false
        dataSource.presenter.commitEditingStyleBlock = { (editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) -> Void in
            executedCommitEditingStyleBlock = true
        }
        dataSource.tableView(self.tableView!, commitEditingStyle: .None, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertTrue(executedCommitEditingStyleBlock)
    }

    func test_commitEditingStyle_withoutBlock_mustDoNothing() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.commitEditingStyleBlock = nil
        dataSource.tableView(self.tableView!, commitEditingStyle: .None, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
    }
    
    
    func test_controllerWillChangeContent_mustNotCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        self.tableView.dataSource = dataSource
        dataSource.controllerWillChangeContent(dataSource.fetchedResultsController)
    }
    
    
    func test_didChangeSection_forInsert_mustNotCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: "ruleName")
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath:NSIndexPath) -> Bool in
            return true
        }
        
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = dataSource
        
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        
        let ruleName = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName2 = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName2,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        dataSource.refreshData()
        
        let ruleName3 = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName3,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        self.tableView.beginUpdates()
        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeSection: section,
            atIndex: 0,
            forChangeType: .Insert)
        dataSource.refreshData()
        self.tableView.endUpdates()
    }

    func test_didChangeSection_forDelete_mustNotCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: "ruleName")
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = dataSource
        
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        
        let ruleName = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName2 = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName2,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName3 = TestUtil().randomRuleName()
        let entityRule = EntitySyncHistory.entityAutoSyncHistoryByName(ruleName3,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        dataSource.refreshData()
        
        dataSource.managedObjectContext.deleteObject(entityRule!)
        
        self.tableView.beginUpdates()
        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeSection: section,
            atIndex: 0,
            forChangeType: .Delete)
        dataSource.refreshData()
        self.tableView.endUpdates()
    }

    func test_didChangeSection_forDefault_mustNotCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: "ruleName")
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = dataSource
        
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        
        let ruleName = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName2 = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName2,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName3 = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName3,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        dataSource.refreshData()
        
        self.tableView.beginUpdates()
        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeSection: section,
            atIndex: 0,
            forChangeType: .Update)
        dataSource.refreshData()
        self.tableView.endUpdates()
    }
    
    
    func test_didChangeObject_forInsert_mustNotCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath:NSIndexPath) -> Bool in
            return true
        }
        
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = dataSource
        
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        
        let ruleName = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName2 = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName2,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        dataSource.refreshData()

        let ruleName3 = TestUtil().randomRuleName()
        let entityRule = EntitySyncHistory.entityAutoSyncHistoryByName(ruleName3,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeObject: entityRule!,
            atIndexPath: nil,
            forChangeType: .Insert,
            newIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        dataSource.refreshData()
        self.tableView.endUpdates()
    }

    func test_didChangeObject_forUpdate_mustNotCrash() {
        let frame = CGRectMake(0, 0, 200, 200)
        let tableView = TestsTableView(frame: frame, style: .Plain)
        tableView.cellForRowAtIndexPathBlock = { () -> UITableViewCell? in
            return TableViewCell()
        }
        let dataSource = createFetcherDataSource(sectionNameKeyPath: nil, tableView: tableView)
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = dataSource

        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        
        
        let ruleName = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)

        let ruleName2 = TestUtil().randomRuleName()
        let entityRule = EntitySyncHistory.entityAutoSyncHistoryByName(ruleName2,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)

        dataSource.refreshData()
        
        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeObject: entityRule!,
            atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
            forChangeType: .Update,
            newIndexPath: nil)
        dataSource.refreshData()
        self.tableView.endUpdates()
    }
    
    func test_didChangeObject_forDelete_mustNotCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath:NSIndexPath) -> Bool in
            return true
        }
        
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = dataSource
        
        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)
        
        let ruleName = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName2 = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName2,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName3 = TestUtil().randomRuleName()
        let entityRule = EntitySyncHistory.entityAutoSyncHistoryByName(ruleName3,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        dataSource.refreshData()
        
        dataSource.managedObjectContext.deleteObject(entityRule!)
        
        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeObject: entityRule!,
            atIndexPath: NSIndexPath(forRow: 2, inSection: 0),
            forChangeType: .Delete,
            newIndexPath: nil)
        dataSource.refreshData()
        self.tableView.endUpdates()
    }
    
    func test_didChangeObject_forMove_mustNotCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath:NSIndexPath) -> Bool in
            return true
        }
        
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = dataSource

        EntitySyncHistory.removeAll(inManagedObjectContext: self.managedObjectContext)

        let ruleName = TestUtil().randomRuleName()
        let entityRule = EntitySyncHistory.entityAutoSyncHistoryByName(ruleName,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)
        
        let ruleName2 = TestUtil().randomRuleName()
        EntitySyncHistory.entityAutoSyncHistoryByName(ruleName2,
            lastExecutionDate: nil,
            inManagedObjectContext: self.managedObjectContext)

        dataSource.refreshData()

        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeObject: entityRule!,
            atIndexPath: NSIndexPath(forRow: 0, inSection: 0),
            forChangeType: .Move,
            newIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        self.tableView.endUpdates()
    }
    
    func test_controllerDidChangeContent_mustNotCrash() {
        let dataSource = self.createFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.controllerDidChangeContent(dataSource.fetchedResultsController)
    }
    
}
