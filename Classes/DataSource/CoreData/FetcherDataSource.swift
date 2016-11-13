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

open class FetcherDataSource<EntityType: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {


    // MARK: - Properties

    open fileprivate(set) var entityName: String
    open var predicate: NSPredicate? {
        didSet {
            self.fetchedResultsController.fetchRequest.predicate = predicate
        }
    }
    open var fetchLimit: NSInteger?
    open var sortDescriptors: [NSSortDescriptor] {
        didSet {
            self.fetchedResultsController.fetchRequest.sortDescriptors = sortDescriptors
        }
    }
    open var sectionNameKeyPath: String?
    open var cacheName: String?
    open let managedObjectContext: NSManagedObjectContext
    open let logger: Logger


    // MARK: - Initialization

    public convenience init(entityName: String,
                sortDescriptors: [NSSortDescriptor],
                managedObjectContext context: NSManagedObjectContext,
                logger: Logger) {

        self.init(entityName: entityName,
                  sortDescriptors: sortDescriptors,
                  managedObjectContext: context,
                  logger:logger,
                  predicate: nil,
                  fetchLimit: nil,
                  sectionNameKeyPath: nil,
                  cacheName: nil)
    }

    public init(entityName: String,
                sortDescriptors: [NSSortDescriptor],
                managedObjectContext context: NSManagedObjectContext,
                logger: Logger,
                predicate: NSPredicate?,
                fetchLimit: NSInteger?,
                sectionNameKeyPath: String?,
                cacheName: String?) {

        self.entityName = entityName
        self.sortDescriptors = sortDescriptors
        self.managedObjectContext = context
        self.logger = logger
        self.predicate = predicate
        self.fetchLimit = fetchLimit
        self.sectionNameKeyPath = sectionNameKeyPath
        self.cacheName = cacheName
        super.init()
    }


    // MARK: - Public Methods

    open func refreshData() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch let error as NSError {
            self.logger.logError(error)
        }
    }

    open func objectAtIndexPath(_ indexPath: IndexPath) -> EntityType? {
        return self.fetchedResultsController.object(at: indexPath)
    }

    open func indexPathForObject(_ object: EntityType) -> IndexPath? {
        return self.fetchedResultsController.indexPath(forObject: object)
    }


    // MARK: - Fetched results controller

    open var fetchedResultsController: NSFetchedResultsController<EntityType> {

        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }

        let fetchRequest = NSFetchRequest<EntityType>()
        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: self.managedObjectContext)
        fetchRequest.entity = entity

        fetchRequest.predicate = self.predicate

        if let fetchLimit = self.fetchLimit, fetchLimit > 0 {
            fetchRequest.fetchLimit = fetchLimit
        }

        fetchRequest.fetchBatchSize = 100
        fetchRequest.sortDescriptors = self.sortDescriptors

        let aFetchedResultsController = self.instantiateFetchedResultsController(fetchRequest,
                                                                                 managedObjectContext: self.managedObjectContext,
                                                                                 sectionNameKeyPath: self.sectionNameKeyPath,
                                                                                 cacheName: self.cacheName)

        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController

        return _fetchedResultsController!
    }
    fileprivate var _fetchedResultsController: NSFetchedResultsController<EntityType>? = nil

    open func instantiateFetchedResultsController(_ fetchRequest: NSFetchRequest<EntityType>,
                                                    managedObjectContext: NSManagedObjectContext,
                                                    sectionNameKeyPath: String?,
                                                    cacheName: String?) -> NSFetchedResultsController<EntityType> {

        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: self.managedObjectContext,
                                          sectionNameKeyPath: self.sectionNameKeyPath,
                                          cacheName: self.cacheName)
    }

}
