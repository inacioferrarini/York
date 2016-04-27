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

public class FetcherDataSource<EntityType: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {

    // MARK: - Properties

    public private(set) var entityName: String
    public var predicate: NSPredicate? {
        didSet {
            self.fetchedResultsController.fetchRequest.predicate = predicate
        }
    }
    public var fetchLimit: NSInteger?
    public var sortDescriptors: [NSSortDescriptor] {
        didSet {
            self.fetchedResultsController.fetchRequest.sortDescriptors = sortDescriptors
        }
    }
    public var sectionNameKeyPath: String?
    public var cacheName: String?
    public let managedObjectContext: NSManagedObjectContext
    public let logger: Logger


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

    public func refreshData() throws {
        try self.fetchedResultsController.performFetch()
    }

    public func objectAtIndexPath(indexPath: NSIndexPath) -> EntityType? {
        return self.fetchedResultsController.objectAtIndexPath(indexPath) as? EntityType
    }

    public func indexPathForObject(object: EntityType) -> NSIndexPath? {
        return self.fetchedResultsController.indexPathForObject(object)
    }


    // MARK: - Fetched results controller

    public var fetchedResultsController: NSFetchedResultsController {

        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }

        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName(self.entityName, inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entity

        fetchRequest.predicate = self.predicate

        if let fetchLimit = self.fetchLimit where fetchLimit > 0 {
            fetchRequest.fetchLimit = fetchLimit
        }

        fetchRequest.fetchBatchSize = 100
        fetchRequest.sortDescriptors = self.sortDescriptors

        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: self.managedObjectContext,
                                                                   sectionNameKeyPath: self.sectionNameKeyPath,
                                                                   cacheName: self.cacheName)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController

        return _fetchedResultsController!
    }
    private var _fetchedResultsController: NSFetchedResultsController? = nil

}
