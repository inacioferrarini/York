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

    var collectionView: UICollectionView!
    var presenter: CollectionViewCellPresenter<UICollectionViewCell, EntityTest>!
    var configureCellBlockWasCalled: Bool = false


    // MARK: - Supporting Methods

    func createCollectionViewFetcherDataSource(sectionNameKeyPath nameKeyPath: String?) -> CollectionViewFetcherDataSource<UICollectionViewCell, EntityTest> {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let layout = UICollectionViewFlowLayout()
        let collectionView = TestsCollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.cellForItemAtIndexPathBlock = { (indexPath: NSIndexPath) -> UICollectionViewCell? in
            return UICollectionViewCell()
        }
        self.registerCellForCollectionView(collectionView)

        return self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nameKeyPath, collectionView: collectionView)
    }

    func registerCellForCollectionView(collectionView: UICollectionView) {
        let collectionViewCellNib = UINib(nibName: "CollectionViewCell", bundle: TestUtil().unitTestsBundle())
        collectionView.registerNib(collectionViewCellNib, forCellWithReuseIdentifier: "CollectionViewCell")
    }

    func createCollectionViewFetcherDataSource(sectionNameKeyPath nameKeyPath: String?, collectionView: UICollectionView!) ->
            CollectionViewFetcherDataSource<UICollectionViewCell, EntityTest> {

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
        self.logger = Logger(logProvider: TestLogProvider())
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
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
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
        let logger = Logger(logProvider: TestLogProvider())
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
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
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
        let logger = Logger(logProvider: TestLogProvider())

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
        dataSource.refreshData()
    }

    func test_refresh_mustIgnoreExceptionCrash() {
        let dataSource = self.createCollectionViewFetcherDataSource(sectionNameKeyPath: nil)
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "nonExistingField", ascending: true) ]
        dataSource.predicate = nil
        dataSource.refreshData()
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


}
