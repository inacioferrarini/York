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

import UIKit
import CoreData

open class CollectionViewFetcherDataSource<CellType: UICollectionViewCell, EntityType: NSManagedObject>: FetcherDataSource<EntityType>, UICollectionViewDataSource {


    // MARK: - Properties

    open let collectionView: UICollectionView
    open let presenter: CollectionViewCellPresenter<CellType, EntityType>


    // MARK: - Initialization

    public convenience init(targetingCollectionView collectionView: UICollectionView,
                presenter: CollectionViewCellPresenter<CellType, EntityType>,
                entityName: String,
                sortDescriptors: [NSSortDescriptor],
                managedObjectContext context: NSManagedObjectContext,
                logger: Logger) {

        self.init(targetingCollectionView: collectionView,
                  presenter: presenter,
                  entityName: entityName,
                  sortDescriptors: sortDescriptors,
                  managedObjectContext: context,
                  logger: logger,
                  predicate: nil,
                  fetchLimit: nil,
                  sectionNameKeyPath: nil,
                  cacheName: nil)
    }

    public init(targetingCollectionView collectionView: UICollectionView,
                presenter: CollectionViewCellPresenter<CellType, EntityType>,
                entityName: String,
                sortDescriptors: [NSSortDescriptor],
                managedObjectContext context: NSManagedObjectContext,
                logger: Logger,
                predicate: NSPredicate?,
                fetchLimit: NSInteger?,
                sectionNameKeyPath: String?,
                cacheName: String?) {

        self.collectionView = collectionView
        self.presenter = presenter

        super.init(entityName: entityName,
                   sortDescriptors: sortDescriptors,
                   managedObjectContext: context,
                   logger: logger,
                   predicate: predicate,
                   fetchLimit: fetchLimit,
                   sectionNameKeyPath: sectionNameKeyPath,
                   cacheName: cacheName)
    }


    // MARK: - Public Methods

    open override func refreshData() {
        super.refreshData()
        self.collectionView.reloadData()
    }


    // MARK: - Collection View Data Source

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = self.fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let value = self.objectAtIndexPath(indexPath)

        let reuseIdentifier = self.presenter.cellReuseIdentifierBlock(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CellType
        if let cell = cell,
            let value = value {
            self.presenter.configureCellBlock(cell, value)
        }
        return cell!
    }


//    // MARK: - private properties
//
//    private var deletedSectionIndexes = NSMutableIndexSet()
//    private var insertedSectionIndexes = NSMutableIndexSet()
//    private var deletedItemIndexPaths = [NSIndexPath]()
//    private var insertedItemIndexPaths = [NSIndexPath]()
//    private var updatedItemIndexPaths = [NSIndexPath]()
//
//
//    // MARK: - Fetched results controller
//
//    public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
//                           atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
//
//        switch type {
//        case .Insert:
//            self.insertedSectionIndexes.addIndex(sectionIndex)
//            break
//        case .Delete:
//            self.deletedSectionIndexes.addIndex(sectionIndex)
//            var indexPathsInSection = [NSIndexPath]()
//
//            for indexPath in self.deletedItemIndexPaths {
//                if indexPath.section == sectionIndex {
//                    indexPathsInSection.append(indexPath)
//                }
//            }
//            self.deletedItemIndexPaths.removeObjectsInArray(indexPathsInSection)
//            indexPathsInSection.removeAll()
//
//            for indexPath in self.updatedItemIndexPaths {
//                if indexPath.section == sectionIndex {
//                    indexPathsInSection.append(indexPath)
//                }
//            }
//            self.updatedItemIndexPaths.removeObjectsInArray(indexPathsInSection)
//
//            break
//        default:
//            break
//        }
//    }
//
//    public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject,
//                           atIndexPath indexPath: NSIndexPath?,
//                           forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//
//        switch type {
//        case .Insert:
//            self.performInsertAtIndexPath(newIndexPath)
//            break
//        case .Delete:
//            self.performRemoveFromIndexPath(atIndexPath: indexPath)
//            break
//        case .Move:
//            self.performMoveObject(atIndexPath: indexPath, newIndexPath: newIndexPath)
//            break
//        case .Update:
//            self.performUpdateObject(atIndexPath: indexPath)
//            break
//        }
//    }
//
//
//    // MARK: - Helper Methods
//
//    func performInsertAtIndexPath(newIndexPath: NSIndexPath?) {
//        if let newIndexPath = newIndexPath {
//            if self.insertedSectionIndexes.containsIndex(newIndexPath.section) {
//                return
//            }
//            self.insertedItemIndexPaths.append(newIndexPath)
//        }
//    }
//
//    func performRemoveFromIndexPath(atIndexPath indexPath: NSIndexPath?) {
//        if let indexPath = indexPath {
//            if self.deletedSectionIndexes.containsIndex(indexPath.section) {
//                return
//            }
//            self.deletedItemIndexPaths.append(indexPath)
//        }
//    }
//
//    func performMoveObject(atIndexPath indexPath: NSIndexPath?, newIndexPath: NSIndexPath?) {
//        if let indexPath = indexPath,
//            let newIndexPath = newIndexPath {
//            if !self.insertedSectionIndexes.containsIndex(newIndexPath.section) {
//                self.insertedItemIndexPaths.append(newIndexPath)
//            }
//            if !self.deletedSectionIndexes.containsIndex(indexPath.section) {
//                self.deletedItemIndexPaths.append(indexPath)
//            }
//        }
//    }
//
//    func performUpdateObject(atIndexPath indexPath: NSIndexPath?) {
//        if let indexPath = indexPath {
//            if self.deletedSectionIndexes.containsIndex(indexPath.section) || self.deletedItemIndexPaths.contains(indexPath) {
//                return
//            }
//            if !self.updatedItemIndexPaths.contains(indexPath) {
//                self.updatedItemIndexPaths.append(indexPath)
//            }
//        }
//    }
//
//
//    public func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        self.commitChanges()
//    }
//
//
//    // MARK: - Collection View Helper
//
//    public func commitChanges() {
//
//        if self.collectionView.window == nil {
//            self.clearChanges()
//            self.collectionView.reloadData()
//        }
//
//        let totalChanges = self.deletedSectionIndexes.count +
//            self.insertedSectionIndexes.count +
//            self.deletedItemIndexPaths.count +
//            self.insertedItemIndexPaths.count +
//            self.updatedItemIndexPaths.count
//
//        if totalChanges > 50 {
//            self.clearChanges()
//            self.collectionView.reloadData()
//            return
//        }
//
//        self.collectionView.performBatchUpdates({
//            self.collectionView.deleteSections(self.deletedSectionIndexes)
//            self.collectionView.insertSections(self.insertedSectionIndexes)
//            self.collectionView.deleteItemsAtIndexPaths(self.deletedItemIndexPaths)
//            self.collectionView.insertItemsAtIndexPaths(self.insertedItemIndexPaths)
//            self.collectionView.reloadItemsAtIndexPaths(self.updatedItemIndexPaths)
//        }) { (finished: Bool) in
//            self.clearChanges()
//        }
//    }
//
//    public func clearChanges() {
//        self.insertedSectionIndexes.removeAllIndexes()
//        self.deletedSectionIndexes.removeAllIndexes()
//        self.deletedItemIndexPaths.removeAll()
//        self.insertedItemIndexPaths.removeAll()
//        self.updatedItemIndexPaths.removeAll()
//    }

}
