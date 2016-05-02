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
import UIKit
import CoreData
import York

class CollectionViewFetcherDataSourceTestsCnt2: CollectionViewFetcherDataSourceTests {


    // MARK: - Tests - didChangeObject

    func test_didChangeObject_forInsert_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)

        dataSource.refreshData()

        let entityRule = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1).first

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entityRule!,
                              atIndexPath: nil,
                              forChangeType: .Insert,
                              newIndexPath: NSIndexPath(forRow: 1, inSection: 0))

        dataSource.refreshData()
    }

    func test_didChangeObject_forInsert_insertedItemFromSameSection_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)

        dataSource.refreshData()

        let entityRule = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1).first

        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeSection: section,
                              atIndex: 0,
                              forChangeType: .Insert)

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entityRule!,
                              atIndexPath: nil,
                              forChangeType: .Insert,
                              newIndexPath: NSIndexPath(forRow: 1, inSection: 0))

        dataSource.refreshData()
    }

    func test_didChangeObject_forUpdate_mustNotCrash() {
        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last

        dataSource.refreshData()

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
                              forChangeType: .Update,
                              newIndexPath: nil)

        dataSource.refreshData()
    }


    func test_didChangeObject_forUpdate_deletedItemFromSameSection_mustNotCrash() {
        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last

        dataSource.refreshData()

        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeSection: section,
                              atIndex: 0,
                              forChangeType: .Delete)

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
                              forChangeType: .Update,
                              newIndexPath: nil)

        dataSource.refreshData()
    }

    func test_didChangeObject_forUpdate_deletedItemFromSameIndexPath_mustNotCrash() {
        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last

        dataSource.refreshData()

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
                              forChangeType: .Update,
                              newIndexPath: nil)

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
                              forChangeType: .Update,
                              newIndexPath: nil)

        dataSource.refreshData()
    }

    func test_didChangeObject_forDelete_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 3, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last

        dataSource.refreshData()

        dataSource.managedObjectContext.deleteObject(entity!)

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 2, inSection: 0),
                              forChangeType: .Delete,
                              newIndexPath: nil)
        dataSource.refreshData()
    }

    func test_didChangeObject_forDelete_deletedItemFromSameSection_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 3, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last

        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeSection: section,
                              atIndex: 0,
                              forChangeType: .Delete)

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 2, inSection: 0),
                              forChangeType: .Delete,
                              newIndexPath: nil)

        dataSource.refreshData()
    }

    func test_didChangeObject_forMove_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()

        let entity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).first

        dataSource.refreshData()

        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entity!,
                              atIndexPath: NSIndexPath(forRow: 0, inSection: 0),
                              forChangeType: .Move,
                              newIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        dataSource.refreshData()
    }


    // MARK: - Tests - controllerDidChangeContent

    func test_controllerDidChangeContent_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.controllerDidChangeContent(dataSource.fetchedResultsController)
    }


    // MARK: - Tests - commitChanges

    func test_commitChanges_withoutWindow_mustNotCrash() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)

        self.registerCellForCollectionView(collectionView)

        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return "CollectionViewCell"
        }

        let presenter = CollectionViewCellPresenter<UICollectionViewCell, EntityTest>(
            configureCellBlock: { (cell: UICollectionViewCell, entity: EntityTest) -> Void in
                self.configureCellBlockWasCalled = true
            }, cellReuseIdentifierBlock: cellReuseIdBlock)
        let entityName = EntityTest.simpleClassName()
        let sortDescriptors = [NSSortDescriptor]()
        let coreDataStack = TestUtil().testAppContext().coreDataStack
        let managedObjectContext = coreDataStack.managedObjectContext
        let logger = Logger(logProvider: TestLogProvider())

        let dataSource = CollectionViewFetcherDataSource<UICollectionViewCell, EntityTest>(
            targetingCollectionView: collectionView,
            presenter: presenter,
            entityName: entityName,
            sortDescriptors: sortDescriptors,
            managedObjectContext: managedObjectContext,
            logger: logger)

        dataSource.commitChanges()
    }

    func test_commitChanges_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.commitChanges()
    }

    func test_commitChanges_MoreThan50Inserts_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)

        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)

        helper.removeAllTestEntities()
        self.coreDataStack.saveContext()

        dataSource.refreshData()

        let totalObjects = 54
        let objects = helper.createTestMass(withSize: totalObjects, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        self.coreDataStack.saveContext()

        for x in 0...totalObjects - 1 {
            let object = objects[x]
            let indexPath = NSIndexPath(forRow: x, inSection: 0)
            dataSource.controller(dataSource.fetchedResultsController,
                                  didChangeObject: object,
                                  atIndexPath: nil,
                                  forChangeType: .Insert,
                                  newIndexPath: indexPath)
        }

        dataSource.commitChanges()
    }


    // MARK: - Tests - clearChanges

    func test_clearChanges_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.clearChanges()
    }

}
