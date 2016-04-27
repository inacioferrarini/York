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

class CollectionViewFetcherDataSourceTests: BaseFetcherDataSourceTests {
    
    
    // MARK: - Properties
    
    var collectionView:UICollectionView!
    var presenter:CollectionViewCellPresenter<UICollectionViewCell, EntityTest>!
    var configureCellBlockWasCalled:Bool = false
    
    
    // MARK: - Supporting Methods
    
    func createCollectionViewFetcherDataSource(sectionNameKeyPath nameKeyPath: String?) -> CollectionViewFetcherDataSource<UICollectionViewCell, EntityTest> {
        let frame = CGRectMake(0, 0, 200, 200)
        let layout = UICollectionViewFlowLayout()
        let collectionView = TestsCollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.cellForItemAtIndexPathBlock = { (indexPath: NSIndexPath) -> UICollectionViewCell? in
            return UICollectionViewCell()
        }
        self.registerCellForCollectionView(collectionView)
        
        return self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nameKeyPath, collectionView: collectionView)
    }
    
    func registerCellForCollectionView(collectionView: UICollectionView) {
        let collectionViewCellNib = UINib(nibName: "CollectionViewCell", bundle: NSBundle(forClass: self.dynamicType))
        collectionView.registerNib(collectionViewCellNib, forCellWithReuseIdentifier: "CollectionViewCell")
    }    
    
    func createCollectionViewFetcherDataSource(sectionNameKeyPath nameKeyPath: String?, collectionView: UICollectionView!) -> CollectionViewFetcherDataSource<UICollectionViewCell, EntityTest> {
        self.collectionView = collectionView
        
        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return "CollectionViewCell"
        }
        
        self.presenter = CollectionViewCellPresenter<UICollectionViewCell, EntityTest>(
            configureCellBlock: { (cell: UICollectionViewCell, entity: EntityTest) -> Void in
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
        
        let dataSource = CollectionViewFetcherDataSource<UICollectionViewCell, EntityTest>(
             targetingCollectionView: self.collectionView,
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
        self.collectionView.dataSource = dataSource
        return dataSource
    }
    
    
    // MARK: - Tests - Initialization
    
    func test_convenienceInitializer_mustSucceed() {
        let frame = CGRectMake(0, 0, 200, 200)
        let layout = UICollectionViewFlowLayout()
        let collectionView = TestsCollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.cellForItemAtIndexPathBlock = { (indexPath: NSIndexPath) -> UICollectionViewCell? in
            return UICollectionViewCell()
        }
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
        let logger = Logger()
        let predicate: NSPredicate? = nil
        let fetchLimit = 100
        let sectionNameKeyPath: String? = nil
        let cacheName = "cacheName"
        
        let dataSource = CollectionViewFetcherDataSource<UICollectionViewCell, EntityTest>(
            targetingCollectionView: collectionView,
            presenter: presenter,
            entityName: entityName,
            sortDescriptors: sortDescriptors,
            managedObjectContext: managedObjectContext,
            logger: logger,
            predicate: predicate,
            fetchLimit: fetchLimit,
            sectionNameKeyPath: sectionNameKeyPath,
            cacheName: cacheName)
        XCTAssertNotNil(dataSource)
    }
    
    func test_designatedInitializer_mustSucceed() {
        let frame = CGRectMake(0, 0, 200, 200)
        let layout = UICollectionViewFlowLayout()
        let collectionView = TestsCollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.cellForItemAtIndexPathBlock = { (indexPath: NSIndexPath) -> UICollectionViewCell? in
            return UICollectionViewCell()
        }
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
        let logger = Logger()

        let dataSource = CollectionViewFetcherDataSource<UICollectionViewCell, EntityTest>(
            targetingCollectionView: collectionView,
            presenter: presenter,
            entityName: entityName,
            sortDescriptors: sortDescriptors,
            managedObjectContext: managedObjectContext,
            logger: logger)
        XCTAssertNotNil(dataSource)
    }
    
    
    // MARK: - Tests - refresh
    
    func test_refresh_mustSucceed() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = []
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_refresh_mustIgnoreExceptionCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "nonExistingField", ascending: true) ]
        dataSource.predicate = nil
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    
    // MARK: - Tests - numberOfSections
    
    func test_numberOfSections_mustReturnZero() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()
        
        self.coreDataStack.saveContext()
        let numberOfSections = dataSource.numberOfSectionsInCollectionView(self.collectionView)
        XCTAssertEqual(numberOfSections, 0)
    }
    
    
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
        helper.createTestMass(withSize: 1, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }

        let numberOfRows = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }
    
    
    // MARK: - Tests - cellForItemAtIndexPath
    
    func test_FetcherDataSource_indexPathForObject_mustSucceed() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        helper.removeAllTestEntities()
        
        helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1)
        
        self.coreDataStack.saveContext()
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = dataSource.collectionView(self.collectionView, cellForItemAtIndexPath: indexPath)
        XCTAssertNotNil(cell)
    }
    
    
    // MARK: - Tests - didChangeSection
    
    func test_didChangeSection_forInsert_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: "sectionName")
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
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
    }
    
    func test_didChangeSection_forDelete_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: "sectionName")
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
    }

    func test_didChangeSection_forDelete_deletedItemFromOtherSection_mustNotCrash() {
        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let entityTest = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entityTest!,
                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
                              forChangeType: .Delete,
                              newIndexPath: nil)
        
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
    }
    
    func test_didChangeSection_forDelete_deletedItemFromSameSection_mustNotCrash() {
        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let entityTest = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entityTest!,
                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
                              forChangeType: .Update,
                              newIndexPath: nil)
        
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
    }
    
    func test_didChangeSection_forDefault_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: "sectionName")
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
    }
    
    
    // MARK: - Tests - didChangeObject
    
    func test_didChangeObject_forInsert_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
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
    }

    func test_didChangeObject_forInsert_insertedItemFromSameSection_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
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
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func test_didChangeObject_forUpdate_mustNotCrash() {
        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let entityTest = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
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
    }


    func test_didChangeObject_forUpdate_deletedItemFromSameSection_mustNotCrash() {
        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let entityTest = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeSection: section,
                              atIndex: 0,
                              forChangeType: .Delete)
        
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
    }

    func test_didChangeObject_forUpdate_deletedItemFromSameIndexPath_mustNotCrash() {
        let dataSource = createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let entityTest = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: entityTest!,
                              atIndexPath: NSIndexPath(forRow: 1, inSection: 0),
                              forChangeType: .Update,
                              newIndexPath: nil)
        
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
    }

    func test_didChangeObject_forDelete_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
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
    }
    
    func test_didChangeObject_forDelete_deletedItemFromSameSection_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let testEntity = helper.createTestMass(withSize: 3, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).last
        
        let section = FetchedResultsSectionInfo(numberOfObjects: 0, objects: nil, name: "Name", indexTitle: "Title")
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeSection: section,
                              atIndex: 0,
                              forChangeType: .Delete)
        
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
    }

    func test_didChangeObject_forMove_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        let helper = CoreDataUtil(inManagedObjectContext: self.managedObjectContext)
        
        helper.removeAllTestEntities()
        
        let testEntity = helper.createTestMass(withSize: 2, usingInitialIndex: 1, inSection: 1, initialOrderValue: 1).first
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        dataSource.controller(dataSource.fetchedResultsController,
                              didChangeObject: testEntity!,
                              atIndexPath: NSIndexPath(forRow: 0, inSection: 0),
                              forChangeType: .Move,
                              newIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    
    // MARK: - Tests - controllerDidChangeContent
    
    func test_controllerDidChangeContent_mustNotCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.controllerDidChangeContent(dataSource.fetchedResultsController)
    }
    
    
    // MARK: - Tests - commitChanges
    
    func test_commitChanges_withoutWindow_mustNotCrash() {
        let frame = CGRectMake(0, 0, 200, 200)
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
        let logger = Logger()
        
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
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
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
