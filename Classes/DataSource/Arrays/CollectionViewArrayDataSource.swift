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

public class CollectionViewArrayDataSource<CellType: UICollectionViewCell, Type: Equatable>: ArrayDataSource<Type>, UICollectionViewDataSource {


    // MARK: - Properties

    public let collectionView: UICollectionView
    public private(set) var presenter: CollectionViewCellPresenter<CellType, Type>


    // MARK: - Initialization

    public init(targetingCollectionView collectionView: UICollectionView,
                                   presenter: CollectionViewCellPresenter<CellType, Type>,
                                   objects: [Type]) {

        self.collectionView = collectionView
        self.presenter = presenter

        super.init(objects: objects)
    }


    // MARK: - Public Methods

    public override func refreshData() {
        super.refreshData()
        self.collectionView.reloadData()
    }


    // MARK: - Collection View Data Source

    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        return self.objects.count
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let value = self.objectAtIndexPath(indexPath)
        let reuseIdentifier = self.presenter.cellReuseIdentifierBlock(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? CellType
        if let cell = cell,
            let value = value {
            self.presenter.configureCellBlock(cell, value)
        }
        return cell!
    }

}
