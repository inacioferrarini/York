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

public class TableViewFetcherDataSource<CellType: UITableViewCell, EntityType: NSManagedObject>: FetcherDataSource<EntityType>, UITableViewDataSource {


    // MARK: - Properties

    public let tableView: UITableView
    public private(set) var presenter: TableViewCellPresenter<CellType, EntityType>
    public var titleForHeaderInSectionBlock: ((section: Int) -> String?)?


    // MARK: - Initialization

    public convenience init(targetingTableView tableView: UITableView,
                presenter: TableViewCellPresenter<CellType, EntityType>,
                entityName: String,
                sortDescriptors: [NSSortDescriptor],
                managedObjectContext context: NSManagedObjectContext,
                logger: Logger) {

        self.init(targetingTableView: tableView,
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

    public init(targetingTableView tableView: UITableView,
                presenter: TableViewCellPresenter<CellType, EntityType>,
                entityName: String,
                sortDescriptors: [NSSortDescriptor],
                managedObjectContext context: NSManagedObjectContext,
                logger: Logger,
                predicate: NSPredicate?,
                fetchLimit: NSInteger?,
                sectionNameKeyPath: String?,
                cacheName: String?) {

        self.tableView = tableView
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

    public override func refreshData() {
        super.refreshData()
        self.tableView.reloadData()
    }


    // MARK: - Table View Data Source

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = self.fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let value = self.objectAtIndexPath(indexPath)
        let reuseIdentifier = self.presenter.cellReuseIdentifierBlock(indexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? CellType
        if let cell = cell,
            let value = value {
            self.presenter.configureCellBlock(cell, value)
        }
        return cell!
    }

    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let titleBlock = self.titleForHeaderInSectionBlock {
            return titleBlock(section: section)
        }
        return nil
    }

    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let editRowBlock = self.presenter.canEditRowAtIndexPathBlock {
            return editRowBlock(indexPath: indexPath)
        }
        return false
    }

    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if let commitEditingBlock = self.presenter.commitEditingStyleBlock {
            commitEditingBlock(editingStyle: editingStyle, forRowAtIndexPath: indexPath)
        }
    }


    // MARK: - Fetched results controller

    public func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
        atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }

    public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            if let cell = tableView.cellForRowAtIndexPath(indexPath!) as? CellType,
                let value = self.objectAtIndexPath(indexPath!) {
                self.presenter.configureCellBlock(cell, value)
            }
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }

    public func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let heightForHeaderInSectionBlock = self.presenter.heightForHeaderInSectionBlock {
            return heightForHeaderInSectionBlock(section: section)
        }
        return 0
    }

    public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let heightForFooterInSectionBlock = self.presenter.heightForFooterInSectionBlock {
            return heightForFooterInSectionBlock(section: section)
        }
        return 0
    }

    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let viewForHeaderInSectionBlock = self.presenter.viewForHeaderInSectionBlock {
            return viewForHeaderInSectionBlock(section: section)
        }
        return nil
    }

    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let viewForFooterInSectionBlock = self.presenter.viewForFooterInSectionBlock {
            return viewForFooterInSectionBlock(section: section)
        }
        return nil
    }

}
