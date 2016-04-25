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
import CoreData
import York

class CollectionViewCellPresenterTests: XCTestCase {
    
    static let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
        return "ReuseCellID"
    }
    
    static var blockExecutionTest = ""
    
    func createCollectionViewCellPresenter() -> CollectionViewCellPresenter<UICollectionViewCell, EntityTest> {
        let presenter = CollectionViewCellPresenter<UICollectionViewCell, EntityTest>(
            configureCellBlock: { (cell: UICollectionViewCell, entity:EntityTest) -> Void in
                CollectionViewCellPresenterTests.blockExecutionTest = "testExecuted"
            }, cellReuseIdentifierBlock: CollectionViewCellPresenterTests.cellReuseIdBlock)
        return presenter
    }
    
    func test_collectionViewCellPresenterFields_configureCellBlock() {
        let testAppContext = TestUtil().testAppContext()
        let context = testAppContext.coreDataStack.managedObjectContext
        let presenter = self.createCollectionViewCellPresenter()
        let cell = UICollectionViewCell()
        let obj = EntityTest.entityTest(nil, name: "name", order: nil, inManagedObjectContext: context)!
        presenter.configureCellBlock(cell, obj)
        XCTAssertEqual(CollectionViewCellPresenterTests.blockExecutionTest, "testExecuted")
    }
    
    func test_collectionViewCellPresenterFields_reuseIdentifier() {
        let presenter = self.createCollectionViewCellPresenter()
        let presenterReuseId = presenter.cellReuseIdentifierBlock(indexPath: NSIndexPath(forRow: 0, inSection: 0))
        let testReuseId = CollectionViewCellPresenterTests.cellReuseIdBlock(indexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertEqual(presenterReuseId, testReuseId)
    }
    
}
