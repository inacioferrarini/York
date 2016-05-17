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

public class TableViewBlockDelegate: NSObject, UITableViewDelegate {

    public let tableView: UITableView
    public let itemSelectionBlock: ((indexPath: NSIndexPath) -> Void)
    public var heightForRowAtIndexPathBlock: ((indexPath: NSIndexPath) -> CGFloat)?
    public let loadMoreDataBlock: (() -> Void)?

    public init(tableView: UITableView, itemSelectionBlock: ((indexPath: NSIndexPath) -> Void), loadMoreDataBlock:(() -> Void)?) {
        self.itemSelectionBlock = itemSelectionBlock
        self.tableView = tableView
        self.loadMoreDataBlock = loadMoreDataBlock
        super.init()
    }

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 0
        if let heightForRowAtIndexPathBlock = self.heightForRowAtIndexPathBlock {
            height = heightForRowAtIndexPathBlock(indexPath: indexPath)
        } else {
            height = UITableViewAutomaticDimension
        }
        return height
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
