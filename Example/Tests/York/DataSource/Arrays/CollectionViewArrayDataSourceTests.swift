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

class CollectionViewArrayDataSourceTests: XCTestCase {


    // MARK: - Properties

    var collectionView: UICollectionView!
    var presenter: CollectionViewCellPresenter<UICollectionViewCell, NSNumber>!
    var configureCellBlockWasCalled: Bool = false


    // MARK: - Supporting Methods

    func createCollectionViewArrayDataSource() -> CollectionViewArrayDataSource<UICollectionViewCell, NSNumber> {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let layout = UICollectionViewFlowLayout()
        let collectionView = TestsCollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.cellForItemAtIndexPathBlock = { (indexPath: NSIndexPath) -> UICollectionViewCell? in
            return UICollectionViewCell()
        }
        self.registerCellForCollectionView(collectionView)
        self.collectionView = collectionView

        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return "CollectionViewCell"
        }
        self.presenter = CollectionViewCellPresenter<UICollectionViewCell, NSNumber>(
            configureCellBlock: { (cell: UICollectionViewCell, entity: NSNumber) -> Void in
                self.configureCellBlockWasCalled = true
            }, cellReuseIdentifierBlock: cellReuseIdBlock)

        let dataSource = CollectionViewArrayDataSource<UICollectionViewCell, NSNumber>(
            targetingCollectionView: self.collectionView,
            presenter: self.presenter,
            objects: [10, 20, 30, 40])
        self.collectionView.dataSource = dataSource
        return dataSource
    }

    func registerCellForCollectionView(collectionView: UICollectionView) {
        let collectionViewCellNib = UINib(nibName: "CollectionViewCell", bundle: TestUtil().unitTestsBundle())
        collectionView.registerNib(collectionViewCellNib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    
    // MARK: - Tests - refresh
    
    func test_refresh_mustSucceed() {
        let dataSource = self.createCollectionViewArrayDataSource()
        dataSource.refreshData()
    }


    // MARK: - Tests - numberOfSections

    func test_numberOfSections_mustReturnOne() {
        let dataSource = self.createCollectionViewArrayDataSource()
        let numberOfSections = dataSource.numberOfSectionsInCollectionView(self.collectionView)
        XCTAssertEqual(numberOfSections, 1)
    }


    // MARK: - Tests - numberOfItemsInSection

    func test_numberOfItemsInSection_mustReturnZero() {
        let dataSource = self.createCollectionViewArrayDataSource()
        let numberOfItems = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 1)
        XCTAssertEqual(numberOfItems, 0)
    }

    func test_numberOfItemsInSection_mustReturnFour() {
        let dataSource = self.createCollectionViewArrayDataSource()
        let numberOfItems = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfItems, 4)
    }


    // MARK: - Tests - cellForItemAtIndexPath

    func test_cellForItemAtIndexPath_mustReturnCell() {
        let dataSource = self.createCollectionViewArrayDataSource()
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        dataSource.collectionView(self.collectionView, cellForItemAtIndexPath: indexPath)
        XCTAssertTrue(self.configureCellBlockWasCalled)
    }

}
