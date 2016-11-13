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

    var tableView: UITableView!
    var presenter: TableViewCellPresenter<UITableViewCell, EntityTest>!
    var configureCellBlockWasCalled: Bool = false


    // MARK: - Supporting Methods

    func createTableViewFetcherDataSource(sectionNameKeyPath nameKeyPath: String?) -> TableViewFetcherDataSource<UITableViewCell, EntityTest> {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let tableView = TestsTableView(frame: frame, style: .plain)
        tableView.cellForRowAtIndexPathBlock = { (indexPath: IndexPath) -> UITableViewCell? in
            return TableViewCell()
        }
        self.registerCellForTableView(tableView)

        return self.createTableViewFetcherDataSource(sectionNameKeyPath: nameKeyPath, tableView: tableView)
    }

    func registerCellForTableView(_ tableView: UITableView) {
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: TestUtil().unitTestsBundle())
        tableView.register(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
    }

    func createTableViewFetcherDataSource(sectionNameKeyPath nameKeyPath: String?, tableView: UITableView!) -> TableViewFetcherDataSource<UITableViewCell, EntityTest> {
        self.tableView = tableView

        let cellReuseIdBlock: ((_ indexPath: IndexPath) -> String) = { (indexPath: IndexPath) -> String in
            return "TableViewCell"
        }

        self.presenter = TableViewCellPresenter<UITableViewCell, EntityTest>(
            configureCellBlock: { (cell: UITableViewCell, entity: EntityTest) -> Void in
                self.configureCellBlockWasCalled = true
            }, cellReuseIdentifierBlock: cellReuseIdBlock)
        self.entityName = EntityTest.simpleClassName()
        self.sortDescriptors = []
        self.coreDataStack = TestUtil().testAppContext().coreDataStack
        self.managedObjectContext = self.coreDataStack.managedObjectContext
        self.logger = Logger(logProvider: TestLogProvider())
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
        dataSource.refreshData()
    }


    func test_refresh_mustIgnoreExceptionCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "nonExistingField", ascending: true) ]
        dataSource.refreshData()
    }


    // MARK: - Tests - numberOfSections

    func test_numberOfSections_mustReturnZero() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()
        self.coreDataStack.saveContext()
        let numberOfSections = dataSource.numberOfSections(in: self.tableView)
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
        _ = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)

        dataSource.refreshData()

        let numberOfRows = dataSource.tableView(self.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }


    // MARK: - Tests - canEditRowAtIndexPath

    func test_canEditRowAtIndexPath_withBlock_mustSucceed() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: IndexPath) -> Bool in
            return true
        }
        let canEdit = dataSource.tableView(self.tableView, canEditRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(canEdit)
    }

    func test_canEditRowAtIndexPath_withoutBlock_mustFail() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = nil
        let canEdit = dataSource.tableView(self.tableView, canEditRowAt: IndexPath(row: 0, section: 0))
        XCTAssertFalse(canEdit)
    }


    // MARK: - Tests - commitEditingStyle

    func test_commitEditingStyle_withBlock_mustExecuteBlock() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        var executedCommitEditingStyleBlock = false
        dataSource.presenter.commitEditingStyleBlock = { (editingStyle: UITableViewCellEditingStyle, indexPath: IndexPath) -> Void in
            executedCommitEditingStyleBlock = true
        }
        dataSource.tableView(self.tableView!, commit: .none, forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(executedCommitEditingStyleBlock)
    }

    func test_commitEditingStyle_withoutBlock_mustDoNothing() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.commitEditingStyleBlock = nil
        dataSource.tableView(self.tableView!, commit: .none, forRowAt: IndexPath(row: 0, section: 0))
    }


    // MARK: - Tests - controllerWillChangeContent

    func test_controllerWillChangeContent_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        self.tableView.dataSource = dataSource
        dataSource.controllerWillChangeContent(dataSource.fetchedResultsController)
    }

}
