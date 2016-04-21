import UIKit
import York

class TestBaseTableViewController: BaseTableViewController {

    override func createDataSource() -> UITableViewDataSource? {

        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return "TableViewCell"
        }

        let presenter = TableViewCellPresenter<UITableViewCell, EntitySyncHistory>(
            configureCellBlock: { (cell: UITableViewCell, entity:EntitySyncHistory) -> Void in
                
            }, cellReuseIdentifierBlock: cellReuseIdBlock)
        
        let sortDescriptors:[NSSortDescriptor] = []
        let context = self.appContext.coreDataStack.managedObjectContext
        let logger = appContext.logger
        
        let dataSource = TableViewFetcherDataSource<UITableViewCell, EntitySyncHistory>(
            targetingTableView: self.tableView!,
            presenter: presenter,
            entityName: EntitySyncHistory.simpleClassName(),
            sortDescriptors: sortDescriptors,
            managedObjectContext: context,
            logger: logger)
        
        return dataSource
    }
    
    override func createDelegate() -> UITableViewDelegate? {
        let itemSelectionBlock = { (indexPath:NSIndexPath) -> Void in

        }
        return TableViewBlockDelegate(tableView: self.tableView!, itemSelectionBlock: itemSelectionBlock, loadMoreDataBlock: nil)
    }
    
}
