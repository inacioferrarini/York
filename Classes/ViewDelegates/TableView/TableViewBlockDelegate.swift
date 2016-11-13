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

open class TableViewBlockDelegate<CellType: UITableViewCell>: NSObject, UITableViewDelegate {

    open let tableView: UITableView
    open var itemSelectionBlock: ((_ indexPath: IndexPath) -> Void)?
    open var heightForRowAtIndexPathBlock: ((_ indexPath: IndexPath) -> CGFloat)?
    open var loadMoreDataBlock: (() -> Void)?
    open var willDisplayCellBlock: ((CellType, IndexPath) -> Void)?
    open var didEndDisplayingCellBlock: ((CellType, IndexPath) -> Void)?

    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = tableView.rowHeight
        if let heightForRowAtIndexPathBlock = self.heightForRowAtIndexPathBlock {
            height = heightForRowAtIndexPathBlock(indexPath)
        }
        return height
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectRowBlock = self.itemSelectionBlock {
            selectRowBlock(indexPath)
        }
    }

    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView.contentOffset.y < 0 {
            return
        } else if self.tableView.contentOffset.y >= self.tableView.contentSize.height - self.tableView.bounds.size.height {
            if let loadMoreDataBlock = self.loadMoreDataBlock {
                loadMoreDataBlock()
            }
        }
    }


    // MARK: - Cell Visibility

    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CellType else { return }
        guard let block = self.willDisplayCellBlock else { return }
        block(cell, indexPath)
    }

    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CellType else { return }
        guard let block = self.didEndDisplayingCellBlock else { return }
        block(cell, indexPath)
    }

}
