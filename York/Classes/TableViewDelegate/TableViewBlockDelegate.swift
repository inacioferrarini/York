import UIKit
import CoreData

public class TableViewBlockDelegate: NSObject, UITableViewDelegate {

    public let tableView:UITableView
    public let itemSelectionBlock:((indexPath: NSIndexPath) -> Void)
    public let loadMoreDataBlock:(() -> Void)?
    
    public init(tableView:UITableView, itemSelectionBlock:((indexPath: NSIndexPath) -> Void), loadMoreDataBlock:(() -> Void)?) {
        self.itemSelectionBlock = itemSelectionBlock
        self.tableView = tableView
        self.loadMoreDataBlock = loadMoreDataBlock
        super.init()
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.itemSelectionBlock(indexPath: indexPath)
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.tableView.contentOffset.y < 0 {
            return
        } else if self.tableView.contentOffset.y >= self.tableView.contentSize.height - self.tableView.bounds.size.height {
            if let loadMoreDataBlock = self.loadMoreDataBlock {
                loadMoreDataBlock()
            }
        }
    }
    
}
