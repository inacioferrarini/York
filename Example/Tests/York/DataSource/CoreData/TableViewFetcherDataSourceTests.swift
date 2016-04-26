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

class TableViewFetcherDataSourceTests: BaseFetcherDataSourceTests {
    
    
    // MARK: - Properties
    
    var tableView:UITableView!
    var presenter:TableViewCellPresenter<UITableViewCell, EntityTest>!
    var configureCellBlockWasCalled:Bool = false
    
    
    // MARK: - Supporting Methods
    
    func createTableViewFetcherDataSource(sectionNameKeyPath nameKeyPath: String?) -> TableViewFetcherDataSource<UITableViewCell, EntityTest> {
        let frame = CGRectMake(0, 0, 200, 200)
        let tableView = UITableView(frame: frame, style: .Plain)
        self.registerCellForTableView(tableView)
        
        return self.createTableViewFetcherDataSource(sectionNameKeyPath: nameKeyPath, tableView: tableView)
    }
    
    func registerCellForTableView(tableView: UITableView) {
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: NSBundle(forClass: self.dynamicType))
        tableView.registerNib(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
    }
    
    func createTableViewFetcherDataSource(sectionNameKeyPath nameKeyPath: String?, tableView: UITableView!) -> TableViewFetcherDataSource<UITableViewCell, EntityTest> {
        self.tableView = tableView

        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return "TableViewCell"
        }

        self.presenter = TableViewCellPresenter<UITableViewCell, EntityTest>(
            configureCellBlock: { (cell: UITableViewCell, entity:EntityTest) -> Void in
                self.configureCellBlockWasCalled = true
            }, cellReuseIdentifierBlock: cellReuseIdBlock)
        self.entityName = EntityTest.simpleClassName()
        self.sortDescriptors = []
        self.coreDataStack = TestUtil().testAppContext().coreDataStack
        self.managedObjectContext = self.coreDataStack.managedObjectContext
        self.logger = Logger()
        self.predicate = nil
        self.fetchLimit = 100
        self.sectionNameKeyPath = nameKeyPath
        self.cacheName = "cacheName"
        
        let dataSource = TableViewFetcherDataSource<UITableViewCell, EntityTest>(targetingTableView: self.tableView,
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
        self.tableView.dataSource = dataSource
        return dataSource
    }
    
    
    // MARK: - Tests - Refresh

    func test_refresh_mustSucceed() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = []
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    
    func test_refresh_mustIgnoreExceptionCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "nonExistingField", ascending: true) ]
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    

    // MARK: - Tests - numberOfSections
    
    func test_numberOfSections_mustReturnZero() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()
        self.coreDataStack.saveContext()
        let numberOfSections = dataSource.numberOfSectionsInTableView(self.tableView)
        XCTAssertEqual(numberOfSections, 0)
    }
    
    
    // MARK: - Tests - numberOfRowsInSection
    
    func test_numberOfRowsInSection_mustReturnZero() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()
        
        let numberOfRows = dataSource.tableView(self.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_numberOfRowsInSection_mustReturnNonZero() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }

        let numberOfRows = dataSource.tableView(self.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }
    
    
    // MARK: - Tests - canEditRowAtIndexPath
    
    func test_canEditRowAtIndexPath_withBlock_mustSucceed() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> Bool in
            return true
        }
        let canEdit = dataSource.tableView(self.tableView, canEditRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertTrue(canEdit)
    }
    
    func test_canEditRowAtIndexPath_withoutBlock_mustFail() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = nil
        let canEdit = dataSource.tableView(self.tableView, canEditRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertFalse(canEdit)
    }

    
    // MARK: - Tests - commitEditingStyle
    
    func test_commitEditingStyle_withBlock_mustExecuteBlock() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        var executedCommitEditingStyleBlock = false
        dataSource.presenter.commitEditingStyleBlock = { (editingStyle: UITableViewCellEditingStyle, indexPath: NSIndexPath) -> Void in
            executedCommitEditingStyleBlock = true
        }
        dataSource.tableView(self.tableView!, commitEditingStyle: .None, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertTrue(executedCommitEditingStyleBlock)
    }

    func test_commitEditingStyle_withoutBlock_mustDoNothing() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.commitEditingStyleBlock = nil
        dataSource.tableView(self.tableView!, commitEditingStyle: .None, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
    }
    
    
    // MARK: - Tests - controllerWillChangeContent
    
    func test_controllerWillChangeContent_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        self.tableView.dataSource = dataSource
        dataSource.controllerWillChangeContent(dataSource.fetchedResultsController)
    }
    
    
    // MARK: - Tests - didChangeSection
    
    func test_didChangeSection_forInsert_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath:NSIndexPath) -> Bool in
            return true
        }
        
        helper.removeAllTestEntities()
        
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 2)
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }

        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 3)
        
        self.tableView.beginUpdates()
        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeSection: section,
            atIndex: 0,
            forChangeType: .Insert)
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        self.tableView.endUpdates()
    }

    func test_didChangeSection_forDelete_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)
        let entityTest = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1).last
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        dataSource.managedObjectContext.deleteObject(entityTest!)
        
        self.tableView.beginUpdates()
        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeSection: section,
            atIndex: 0,
            forChangeType: .Delete)
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        self.tableView.endUpdates()
    }

    func test_didChangeSection_forDefault_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1)
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        self.tableView.beginUpdates()
        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeSection: section,
            atIndex: 0,
            forChangeType: .Update)
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        self.tableView.endUpdates()
    }
    
    
    // MARK: - Tests - didChangeObject
    
    func test_didChangeObject_forInsert_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath:NSIndexPath) -> Bool in
            return true
        }
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        let entityRule = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1).first
        
        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeObject: entityRule!,
            atIndexPath: nil,
            forChangeType: .Insert,
            newIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        self.tableView.endUpdates()
    }

    func test_didChangeObject_forUpdate_mustNotCrash() {
        let frame = CGRectMake(0, 0, 200, 200)
        let tableView = TestsTableView(frame: frame, style: .Plain)
        tableView.cellForRowAtIndexPathBlock = { () -> UITableViewCell? in
            return TableViewCell()
        }
        self.registerCellForTableView(tableView)
        
        let dataSource = createTableViewFetcherDataSource(sectionNameKeyPath: nil, tableView: tableView)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let entityTest = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }

        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeObject: entityTest!,
            atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
            forChangeType: .Update,
            newIndexPath: nil)
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        self.tableView.endUpdates()
    }
    
    func test_didChangeObject_forDelete_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath:NSIndexPath) -> Bool in
            return true
        }
        
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let testEntity = helper.createTestMass(withSize: 3, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }

        dataSource.managedObjectContext.deleteObject(testEntity!)
        
        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeObject: testEntity!,
            atIndexPath: NSIndexPath(forRow: 2, inSection: 0),
            forChangeType: .Delete,
            newIndexPath: nil)
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        self.tableView.endUpdates()
    }
    
    func test_didChangeObject_forMove_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath:NSIndexPath) -> Bool in
            return true
        }
        
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()
        
        let testEntity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).first
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }

        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
            didChangeObject: testEntity!,
            atIndexPath: NSIndexPath(forRow: 0, inSection: 0),
            forChangeType: .Move,
            newIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        self.tableView.endUpdates()
    }
    
    
    // MARK: - Tests - controllerDidChangeContent
    
    func test_controllerDidChangeContent_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.controllerDidChangeContent(dataSource.fetchedResultsController)
    }
    
}
