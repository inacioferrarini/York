import UIKit
import CoreData
import York_Swift_Try_Catch

public class FetcherDataSource<CellType: UITableViewCell, EntityType: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    public let tableView:UITableView
    public private(set) var entityName: String
    public var predicate: NSPredicate? {
        didSet {
            self.fetchedResultsController.fetchRequest.predicate = predicate
           // self.refreshData()
        }
    }
    public var fetchLimit: NSInteger?
    public var sortDescriptors: [NSSortDescriptor] {
        didSet {
            self.fetchedResultsController.fetchRequest.sortDescriptors = sortDescriptors
           // self.refreshData()
        }
    }
    public var sectionNameKeyPath: String?
    public var cacheName: String?
    public let managedObjectContext:NSManagedObjectContext
    public private(set) var presenter:TableViewCellPresenter<CellType, EntityType>
    public let logger:Logger
    
    // MARK: - Initialization
    
    public init(targetingTableView tableView:UITableView,
         presenter:TableViewCellPresenter<CellType, EntityType>,
         entityName: String,
         sortDescriptors: [NSSortDescriptor],
         managedObjectContext context:NSManagedObjectContext,
         logger:Logger) {
    
        self.tableView = tableView
        self.presenter = presenter
        self.entityName = entityName
        self.sortDescriptors = sortDescriptors
        self.managedObjectContext = context
        self.logger = logger
        super.init()
    }
    
    public convenience init(targetingTableView tableView:UITableView,
         presenter:TableViewCellPresenter<CellType, EntityType>,
         entityName: String,
         sortDescriptors: [NSSortDescriptor],
         managedObjectContext context:NSManagedObjectContext,
         logger:Logger,
         predicate: NSPredicate?,
         fetchLimit: NSInteger?,
         sectionNameKeyPath: String?,
         cacheName: String?) {
            
        self.init(targetingTableView: tableView, presenter:presenter, entityName: entityName, sortDescriptors: sortDescriptors, managedObjectContext: context, logger:logger)
        self.predicate = predicate
        self.fetchLimit = fetchLimit
        self.sectionNameKeyPath = sectionNameKeyPath
        self.cacheName = cacheName
    }
    
    
    // MARK: - Public Methods
    
    public func refreshData() {
        
        TryCatchFinally.handleTryBlock({ () -> Void in
                try! self.fetchedResultsController.performFetch()
                self.tableView.reloadData()
            }) { (exception: NSException!) -> Void in
                let error = NSError(domain: "", code: 9999, userInfo: exception.userInfo)
                self.logger.logError(error)
        }
        
    }
    
    public func objectAtIndexPath(indexPath: NSIndexPath) -> EntityType {
        return self.fetchedResultsController.objectAtIndexPath(indexPath) as! EntityType
    }
    
    public func indexPathForObject(object: EntityType) -> NSIndexPath? {
        return self.fetchedResultsController.indexPathForObject(object)
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
        
        let reuseIdentifier = self.presenter.cellReuseIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CellType

        self.presenter.configureCellBlock(cell, value)
        
        return cell
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

        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: self.sectionNameKeyPath, cacheName: self.cacheName)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        return _fetchedResultsController!
    }
    public var _fetchedResultsController: NSFetchedResultsController? = nil
    
    public func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }

    public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            let value = self.objectAtIndexPath(indexPath!)
            if let cell = tableView.cellForRowAtIndexPath(indexPath!) as? CellType {
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
    
}