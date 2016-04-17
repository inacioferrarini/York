import XCTest
import York

class TableViewBlockDelegateTests: XCTestCase {

    var tableView:UITableView!
    var itemSelectionBlock:((indexPath: NSIndexPath) -> Void)!
    var loadMoreDataBlock:(() -> Void)!
    var itemSelectionBlockWasCalled:Bool = false
    var loadMoreDataBlockWasCalled:Bool = false
    
    func createTableViewBlockDelegate() -> TableViewBlockDelegate {
        self.tableView = UITableView()
        self.itemSelectionBlock = { (indexPath:NSIndexPath) -> Void in
            self.itemSelectionBlockWasCalled = true
        }
        self.loadMoreDataBlock = { () -> Void in
            self.loadMoreDataBlockWasCalled = true
        }
        return TableViewBlockDelegate(tableView: self.tableView,
            itemSelectionBlock: self.itemSelectionBlock,
            loadMoreDataBlock: self.loadMoreDataBlock)
    }
    
//    func test_tableViewBlockDelegate_itemSelection() {
//        let delegate = self.createTableViewBlockDelegate()
//        delegate.tableView(self.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 1))
//        XCTAssertTrue(self.itemSelectionBlockWasCalled)
//    }
//    
//    func test_tableViewBlockDelegate_viewScrollNegativeContentOffset() {
//        let delegate = self.createTableViewBlockDelegate()
//        self.tableView.contentOffset.y = -20
//        delegate.scrollViewDidScroll(UIScrollView())
//        XCTAssertFalse(self.loadMoreDataBlockWasCalled)
//    }
//    
//    func test_tableViewBlockDelegate_viewScroll() {
//        let delegate = self.createTableViewBlockDelegate()
//        self.tableView.contentOffset.y = 0
//        delegate.scrollViewDidScroll(UIScrollView())
//        XCTAssertTrue(self.loadMoreDataBlockWasCalled)
//    }
    
}