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
import York

open class TestBaseTableViewController: BaseTableViewController, AppContextAwareProtocol {


    open var appContext: FullStackAppContext!


    override open func createDataSource() -> UITableViewDataSource? {

        let cellReuseIdBlock: ((_ indexPath: IndexPath) -> String) = { (indexPath: IndexPath) -> String in
            return "TableViewCell"
        }

        let presenter = TableViewCellPresenter<UITableViewCell, EntityTest>(
            configureCellBlock: { (cell: UITableViewCell, entity: EntityTest) -> Void in

            }, cellReuseIdentifierBlock: cellReuseIdBlock)

        let sortDescriptors: [NSSortDescriptor] = []
        let context = self.appContext.coreDataStack.managedObjectContext
        let logger = appContext.logger

        let dataSource = TableViewFetcherDataSource<UITableViewCell, EntityTest>(
            targetingTableView: self.tableView!,
            presenter: presenter,
            entityName: EntityTest.simpleClassName(),
            sortDescriptors: sortDescriptors,
            managedObjectContext: context,
            logger: logger)

        return dataSource
    }

    override open func createDelegate() -> UITableViewDelegate? {
        return TableViewBlockDelegate(tableView: self.tableView!)
    }

    override open func createRefreshControl() -> UIRefreshControl? {
        return UIRefreshControl()
    }

}
