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

class ArrayDataSourceTests: XCTestCase {


    // MARK: - Supporting Methods

    func createArrayDataSource() -> ArrayDataSource<NSNumber> {
        return ArrayDataSource<NSNumber>(objects: [10, 20, 30, 40])
    }


    // MARK: - Tests - Initialization

    func test_initializer_withObjects() {
        let dataSource = self.createArrayDataSource()
        XCTAssertEqual(dataSource.objects, [10, 20, 30, 40])
    }

    
    // MARK: - Tests - refresh

    func test_refresh_mustSucceed() {
        let dataSource = self.createArrayDataSource()
        dataSource.refreshData()
    }


    // MARK: - Tests - objectAtIndexPath

    func test_objectAtIndexPath_mustReturnObject() {
        let dataSource = self.createArrayDataSource()
        let value = dataSource.objectAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))
        XCTAssertEqual(value, 30)
    }

    func test_objectAtIndexPath_sectionGreaterThanZero_mustReturnNil() {
        let dataSource = self.createArrayDataSource()
        let value = dataSource.objectAtIndexPath(NSIndexPath(forRow: 2, inSection: 1))
        XCTAssertNil(value)
    }

    func test_objectAtIndexPath_nonExistingIndex_mustReturnNil() {
        let dataSource = self.createArrayDataSource()
        let value = dataSource.objectAtIndexPath(NSIndexPath(forRow: 10, inSection: 0))
        XCTAssertNil(value)
    }


    // MARK: - Tests - indexPathForObject

    func test_indexPathForObject_mustSucceed() {
        let dataSource = self.createArrayDataSource()
        let indexPath = dataSource.indexPathForObject(30)
        let desiredIndexPath = NSIndexPath(forRow: 2, inSection: 0)
        XCTAssertEqual(desiredIndexPath, indexPath)
    }

}
