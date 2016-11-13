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

open class BaseCollectionViewController: BaseDataBasedViewController {


    // MARK: - Properties

    @IBOutlet open weak var collectionView: UICollectionView?

    open var dataSource: UICollectionViewDataSource?
    open var delegate: UICollectionViewDelegate?


    // MARK: - Initialization

    override open func viewDidLoad() {
        super.viewDidLoad()

        if let collectionView = self.collectionView {
            self.setupCollectionView()

            if let selfAsDataSource = self as? UICollectionViewDataSource {
                collectionView.dataSource = selfAsDataSource
            } else {
                self.dataSource = self.createDataSource()
                collectionView.dataSource = self.dataSource
            }

            if let selfAsDelegate = self as? UICollectionViewDelegate {
                collectionView.delegate = selfAsDelegate
            } else {
                self.delegate = self.createDelegate()
                collectionView.delegate = self.delegate
            }
        }
    }


    // MARK: - Child classes are expected to override these methods

    open func setupCollectionView() {}

    open func createDataSource() -> UICollectionViewDataSource? { return nil }

    open func createDelegate() -> UICollectionViewDelegate? { return nil }

}
