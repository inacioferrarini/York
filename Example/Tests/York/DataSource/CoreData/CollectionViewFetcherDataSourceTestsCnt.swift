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


class CollectionViewFetcherDataSourceTestsCnt: CollectionViewFetcherDataSourceTests {


    // MARK: - Tests - numberOfItemsInSection

    func test_numberOfItemsInSection_mustReturnZero() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)

        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()

        let numberOfRows = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfRows, 0)
    }

    func test_numberOfItemsInSection_mustReturnNonZero() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)

        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()
        _ = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)

        dataSource.refreshData()

        let numberOfRows = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }


    // MARK: - Tests - cellForItemAtIndexPath

    func test_FetcherDataSource_indexPathForObject_mustSucceed() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()

        _ = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)

        self.coreDataStack.saveContext()
        dataSource.refreshData()

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = dataSource.collectionView(self.collectionView, cellForItemAt: indexPath)
        XCTAssertNotNil(cell)
    }


//    // MARK: - Tests - didChangeSection
//
//    func test_didChangeSection_forInsert_mustNotCrash() {
//        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: "sectionName")
//        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
//
//        helper.removeAllTestEntities()
//
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 2)
//
//        dataSource.refreshData()
//
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 3)
//
//        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
//        dataSource.controller(dataSource.fetchedResultsController,
//                              didChangeSection: section,
//                              atIndex: 0,
//                              forChangeType: .Insert)
//        dataSource.refreshData()
//    }

//    func test_didChangeSection_forDelete_mustNotCrash() {
//        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: "sectionName")
//        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
//
//        helper.removeAllTestEntities()
//
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)
//        let entity = helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1).last
//
//        dataSource.refreshData()
//        dataSource.managedObjectContext.deleteObject(entity!)
//
//        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
//        dataSource.controller(dataSource.fetchedResultsController,
//                              didChangeSection: section,
//                              atIndex: 0,
//                              forChangeType: .Delete)
//
//        dataSource.refreshData()
//    }

//    func test_didChangeSection_forDelete_deletedItemFromOtherSection_mustNotCrash() {
//        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
//        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
//
//        helper.removeAllTestEntities()
//
//        let entity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
//
//        dataSource.refreshData()
//
//        dataSource.controller(dataSource.fetchedResultsController,
//                              didChangeObject: entity!,
//                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
//                              forChangeType: .Delete,
//                              newIndexPath: nil)
//
//        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
//        dataSource.controller(dataSource.fetchedResultsController,
//                              didChangeSection: section,
//                              atIndex: 0,
//                              forChangeType: .Delete)
//
//        dataSource.refreshData()
//    }

//    func test_didChangeSection_forDelete_deletedItemFromSameSection_mustNotCrash() {
//        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
//        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
//
//        helper.removeAllTestEntities()
//
//        let entity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
//
//        dataSource.refreshData()
//
//        dataSource.controller(dataSource.fetchedResultsController,
//                              didChangeObject: entity!,
//                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
//                              forChangeType: .Update,
//                              newIndexPath: nil)
//
//        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
//        dataSource.controller(dataSource.fetchedResultsController,
//                              didChangeSection: section,
//                              atIndex: 0,
//                              forChangeType: .Delete)
//
//        dataSource.refreshData()
//    }

//    func test_didChangeSection_forDefault_mustNotCrash() {
//        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: "sectionName")
//        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
//
//        helper.removeAllTestEntities()
//
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 2, initialOrderValue: 1)
//        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 3, initialOrderValue: 1)
//
//        dataSource.refreshData()
//
//        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
//        dataSource.controller(dataSource.fetchedResultsController,
//                              didChangeSection: section,
//                              atIndex: 0,
//                              forChangeType: .Update)
//
//        dataSource.refreshData()
//    }

}
