import UIKit

public class BaseTableViewController: BaseDataBasedViewController {

    // MARK: - Properties
    
    public var refreshControl:UIRefreshControl?
    @IBOutlet public weak var tableView: UITableView?
    
    public var dataSource:UITableViewDataSource?
    public var delegate:UITableViewDelegate?
    
    private var tableViewBGView:UIView?
    
    
    // MARK: - Initialization
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if let tableView = self.tableView {
            self.setupTableView()
            self.tableViewBGView = tableView.backgroundView
            
            if let selfAsDataSource = self as? UITableViewDataSource {
                tableView.dataSource = selfAsDataSource
            } else {
                self.dataSource = self.createDataSource()
                tableView.dataSource = self.dataSource
            }
            
            if let selfAsDelegate = self as? UITableViewDelegate {
                tableView.delegate = selfAsDelegate
            } else {
                self.delegate = self.createDelegate()
                tableView.delegate = self.delegate
            }
            
            
            self.refreshControl = UIRefreshControl()
            if let refreshControl = self.refreshControl {
                refreshControl.backgroundColor = UIColor.blackColor()
                refreshControl.tintColor = UIColor.whiteColor()
                refreshControl.addTarget(self, action: Selector("performDataSync"), forControlEvents: .ValueChanged)

                tableView.addSubview(refreshControl)
                tableView.reloadData()
            }
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performDataSyncIfNeeded()
    }
    
    override public func viewWillDisappear(animated: Bool) {

        if let tableView = self.tableView,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
        
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: - Data Syncrhonization
    
    override public func performDataSync() {
        dataSyncCompleted()
    }
    
    override public func dataSyncCompleted() {
        if let refreshControl = self.refreshControl {
            refreshControl.endRefreshing()
        }
        super.dataSyncCompleted()
    }
    
    
    // MARK: - TableView Appearance
    
    public func defaultEmptyResultsBackgroundView() -> UIView? {
        return tableViewBGView
    }
    
    public func defaultNonEmptyResultsBackgroundView() -> UIView? {
        return tableViewBGView
    }
    

    // MARK: - Child classes are expected to override these methods
    
    public func setupTableView() {}
    
    public func createDataSource() -> UITableViewDataSource? { return nil }
    
    public func createDelegate() -> UITableViewDelegate? { return nil }
    
}
