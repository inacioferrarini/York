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

// This component is heavilly based on http://dativestudios.com/blog/2015/01/08/collection_view_layouts_on_wide_phones/

@IBDesignable
public class CollectionViewColumnLayout: UICollectionViewFlowLayout {


    // MARK: - Properties

    @IBInspectable
    public var numberOfItemsPerRow: Int = 2 {
        didSet {
            invalidateLayout()
        }
    }


    // MARK: - UICollectionViewFlowLayout override

    public override func prepareLayout() {
        super.prepareLayout()
        guard let collectionView = self.collectionView else { return }
        var newItemSize = itemSize
        let itemsPerRow = CGFloat(max(numberOfItemsPerRow, 1))
        let totalSpacing = minimumInteritemSpacing * (itemsPerRow - 1.0)
        newItemSize.width = (collectionView.bounds.size.width - totalSpacing) / itemsPerRow
        itemSize = newItemSize
    }

}