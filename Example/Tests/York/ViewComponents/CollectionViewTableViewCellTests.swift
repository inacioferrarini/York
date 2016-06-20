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

class CollectionViewTableViewCellTests: XCTestCase {


    // MARK: - Properties

    var collectionView: UICollectionView!
    var cell: CollectionViewTableViewCell!


    // MARK: - Supporting Methods

    func createCollectionViewTableViewCell() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.cell = CollectionViewTableViewCell()
        self.cell.collectionView = self.collectionView
    }

    func registerCellForCollectionView() {
        let collectionViewCellNib = UINib(nibName: "CollectionViewCell", bundle: TestUtil().unitTestsBundle())
        collectionView.registerNib(collectionViewCellNib, forCellWithReuseIdentifier: "CollectionViewCell")
    }

    func createCollectionViewArrayDataSource(collectionView: UICollectionView) -> CollectionViewArrayDataSource<UICollectionViewCell, NSNumber> {
        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return "CollectionViewCell"
        }
        let presenter = CollectionViewCellPresenter<UICollectionViewCell, NSNumber>(
            configureCellBlock: { (cell: UICollectionViewCell, entity: NSNumber) -> Void in
            }, cellReuseIdentifierBlock: cellReuseIdBlock)

        let dataSource = CollectionViewArrayDataSource<UICollectionViewCell, NSNumber>(
            targetingCollectionView: self.collectionView,
            presenter: presenter,
            objects: [10, 20, 30, 40])
        return dataSource
    }

    func createCollectionViewDelegate() -> CollectionViewBlockDelegate {
        return CollectionViewBlockDelegate(collectionView: self.collectionView)
    }


    // MARK: - Tests

    func test_setDelegate_mustUpdateDelegate() {
        self.createCollectionViewTableViewCell()
        let delegate = self.createCollectionViewDelegate()
        self.cell.delegate = delegate
        let attributedDelegate = self.cell.delegate as? CollectionViewBlockDelegate
        XCTAssertEqual(attributedDelegate, delegate)
    }

    func test_setDataSource_mustUpdateDataSource() {
        self.createCollectionViewTableViewCell()
        let dataSource = self.createCollectionViewArrayDataSource(self.cell.collectionView)
        self.cell.dataSource = dataSource
        let attributedDataSource = self.cell.dataSource as? CollectionViewArrayDataSource<UICollectionViewCell, NSNumber>
        XCTAssertEqual(attributedDataSource, dataSource)
    }

}
