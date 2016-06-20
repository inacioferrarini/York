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

class CollectionViewBlockDelegateTests: XCTestCase {


    // MARK: - Properties

    var collectionView: UICollectionView!
    var itemSelectionBlock: ((indexPath: NSIndexPath) -> Void)!
    var itemSelectionBlockWasCalled: Bool = false


    // MARK: - Supporting Methods

    func createCollectionViewBlockDelegate() -> CollectionViewBlockDelegate {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.itemSelectionBlock = { (indexPath: NSIndexPath) -> Void in
            self.itemSelectionBlockWasCalled = true
        }
        let delegate = CollectionViewBlockDelegate(collectionView: self.collectionView)
        delegate.itemSelectionBlock = self.itemSelectionBlock
        return delegate
    }


    // MARK: - Tests

    func test_itemSelection_mustSelectValue() {
        let delegate = self.createCollectionViewBlockDelegate()
        delegate.collectionView(self.collectionView, didSelectItemAtIndexPath: NSIndexPath(forRow: 1, inSection: 1))
        XCTAssertTrue(self.itemSelectionBlockWasCalled)
    }

}
