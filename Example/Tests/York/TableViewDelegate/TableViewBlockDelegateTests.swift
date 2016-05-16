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

import XCTest
import York

class TableViewBlockDelegateTests: XCTestCase {


    // MARK: - Properties

    var tableView: UITableView!
    var itemSelectionBlock: ((indexPath: NSIndexPath) -> Void)!
    var heightForRowAtIndexPathBlock: ((indexPath: NSIndexPath) -> CGFloat)!
    var loadMoreDataBlock: (() -> Void)!
    var itemSelectionBlockWasCalled: Bool = false
    var loadMoreDataBlockWasCalled: Bool = false


    // MARK: - Supporting Methods

    func createTableViewBlockDelegate() -> TableViewBlockDelegate {
        self.tableView = UITableView()
        self.itemSelectionBlock = { (indexPath: NSIndexPath) -> Void in
            self.itemSelectionBlockWasCalled = true
        }
        self.loadMoreDataBlock = { () -> Void in
            self.loadMoreDataBlockWasCalled = true
        }
        self.heightForRowAtIndexPathBlock = { (indexPath: NSIndexPath) -> CGFloat in
            return 10
        }
        return TableViewBlockDelegate(tableView: self.tableView,
            itemSelectionBlock: self.itemSelectionBlock,
            loadMoreDataBlock: self.loadMoreDataBlock)
    }


    // MARK: - Tests

    func test_tableViewBlockDelegate_itemSelection() {
        let delegate = self.createTableViewBlockDelegate()
        delegate.tableView(self.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 1))
        XCTAssertTrue(self.itemSelectionBlockWasCalled)
    }

    func test_tableViewBlockDelegate_viewScrollNegativeContentOffset() {
        let delegate = self.createTableViewBlockDelegate()
        self.tableView.contentOffset.y = -20
        delegate.scrollViewDidScroll(UIScrollView())
        XCTAssertFalse(self.loadMoreDataBlockWasCalled)
    }

    func test_tableViewBlockDelegate_viewScroll() {
        let delegate = self.createTableViewBlockDelegate()
        self.tableView.contentOffset.y = 0
        delegate.scrollViewDidScroll(UIScrollView())
        XCTAssertTrue(self.loadMoreDataBlockWasCalled)
    }

    func test_heightForRowAtIndexPath_withBlock_mustReturnValue() {
        let delegate = self.createTableViewBlockDelegate()
        delegate.heightForRowAtIndexPathBlock = self.heightForRowAtIndexPathBlock
        let height = delegate.tableView(self.tableView, heightForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertEqual(height, 10)
    }

    func test_heightForRowAtIndexPath_withoutBlock_mustReturnDefaultValue() {
        let delegate = self.createTableViewBlockDelegate()
        delegate.heightForRowAtIndexPathBlock = nil
        let height = delegate.tableView(self.tableView, heightForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertEqual(height, UITableViewAutomaticDimension)
    }

}
