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

class TableViewFetcherDataSourceTestsCnt: TableViewFetcherDataSourceTests {


    // MARK: - Tests - didChangeSection

    func test_didChangeSection_forInsert_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> Bool in
            return true
        }

        helper.removeAllTestEntities()

        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 2)

        dataSource.refreshData()

        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 3)

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
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)
        let entity = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1).last

        dataSource.refreshData()
        dataSource.managedObjectContext.deleteObject(entity!)

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
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1)

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


    // MARK: - Tests - didChangeObject

    func test_didChangeObject_forInsert_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> Bool in
            return true
        }
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)

        dataSource.refreshData()

        let entityRule = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1).first

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
        let dataSource = createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last

        dataSource.refreshData()

        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
                              forChangeType: .Update,
                              newIndexPath: nil)
        dataSource.refreshData()
        self.tableView.endUpdates()
    }

    func test_didChangeObject_forDelete_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> Bool in
            return true
        }

        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 3, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last

        dataSource.refreshData()

        dataSource.managedObjectContext.deleteObject(entity!)

        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 2, inSection: 0),
                              forChangeType: .Delete,
                              newIndexPath: nil)
        dataSource.refreshData()
        self.tableView.endUpdates()
    }

    func test_didChangeObject_forMove_mustNotCrash() {
        let dataSource = self.createTableViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.presenter.canEditRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> Bool in
            return true
        }

        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).first

        dataSource.refreshData()

        self.tableView.beginUpdates()
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
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
