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
import York

public class ErrorProneFetcherDataSource<EntityType: NSManagedObject>: FetcherDataSource<EntityType> {


    // MARK: - Initialization

    public convenience init(entityName: String,
                            sortDescriptors: [NSSortDescriptor],
                            managedObjectContext context: NSManagedObjectContext,
                            logger: Logger) {

        self.init(entityName: entityName,
                  sortDescriptors: sortDescriptors,
                  managedObjectContext: context,
                  logger: logger,
                  predicate: nil,
                  fetchLimit: nil,
                  sectionNameKeyPath: nil,
                  cacheName: nil)
    }

    public override init(entityName: String,
                         sortDescriptors: [NSSortDescriptor],
                         managedObjectContext context: NSManagedObjectContext,
                         logger: Logger,
                         predicate: NSPredicate?,
                         fetchLimit: NSInteger?,
                         sectionNameKeyPath: String?,
                         cacheName: String?) {

        super.init(entityName: entityName,
                   sortDescriptors: sortDescriptors,
                   managedObjectContext: context,
                   logger: logger,
                   predicate: predicate,
                   fetchLimit: fetchLimit,
                   sectionNameKeyPath: sectionNameKeyPath,
                   cacheName: cacheName)
    }


    // MARK: - Fetched results controller

    override public func instantiateFetchedResultsController(fetchRequest: NSFetchRequest,
                                                             managedObjectContext: NSManagedObjectContext,
                                                             sectionNameKeyPath: String?,
                                                             cacheName: String?) -> NSFetchedResultsController {

        return ErrorProneFetchedResultsController(fetchRequest: fetchRequest,
                                                  managedObjectContext: self.managedObjectContext,
                                                  sectionNameKeyPath: self.sectionNameKeyPath,
                                                  cacheName: self.cacheName)
    }

}
