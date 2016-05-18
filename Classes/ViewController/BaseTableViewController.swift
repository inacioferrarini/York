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

public class BaseTableViewController<AppContextType>: BaseDataBasedViewController<AppContextType> {

    // MARK: - Properties

    public var refreshControl: UIRefreshControl?
    @IBOutlet public weak var tableView: UITableView?

    public var dataSource: UITableViewDataSource?
    public var delegate: UITableViewDelegate?

    private var tableViewBGView: UIView?


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
                refreshControl.addTarget(self, action: #selector(self.performDataSync), forControlEvents: .ValueChanged)

                tableView.addSubview(refreshControl)
                tableView.reloadData()
            }
        }
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
