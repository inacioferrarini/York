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

class ArrayOfArrayDataSourceTests: XCTestCase {


    // MARK: - Supporting Methods

    func createArrayOfArrayDataSource() -> ArrayOfArrayDataSource<NSNumber> {
        return ArrayOfArrayDataSource<NSNumber>(objects: [[10], [10, 20], [10, 20, 30, 40]])
    }


    // MARK: - Tests - Initialization

    func test_initializer_withObjects() {
//        let dataSource = self.createArrayOfArrayDataSource()
//        let compareArray: [[NSNumber]] = [[10], [10, 20], [10, 20, 30, 40]]
//        XCTAssertEqual(dataSource.objects, compareArray)
    }


    // MARK: - Tests - refresh

    func test_refresh_mustSucceed() {
        let dataSource = self.createArrayOfArrayDataSource()
        dataSource.refreshData()
    }


    // MARK: - Tests - objectAtIndexPath

    func test_objectAtIndexPath_mustReturnObject() {
        let dataSource = self.createArrayOfArrayDataSource()
        let value = dataSource.objectAtIndexPath(IndexPath(row: 2, section: 2))
        XCTAssertEqual(value, 30)
    }

    func test_objectAtIndexPath_sectionGreaterThanZero_mustReturnNil() {
        let dataSource = self.createArrayOfArrayDataSource()
        let value = dataSource.objectAtIndexPath(IndexPath(row: 2, section: 3))
        XCTAssertNil(value)
    }

    func test_objectAtIndexPath_nonExistingSection_mustReturnNil() {
        let dataSource = self.createArrayOfArrayDataSource()
        let value = dataSource.objectAtIndexPath(IndexPath(row: 10, section: 5))
        XCTAssertNil(value)
    }

    func test_objectAtIndexPath_nonExistingIndex_mustReturnNil() {
        let dataSource = self.createArrayOfArrayDataSource()
        let value = dataSource.objectAtIndexPath(IndexPath(row: 10, section: 0))
        XCTAssertNil(value)
    }


    // MARK: - Tests - indexPathForObject

    func test_indexPathForObject_mustSucceed() {
        let dataSource = self.createArrayOfArrayDataSource()
        let indexPath = dataSource.indexPathForObject(30)
        let desiredIndexPath = IndexPath(row: 2, section: 2)
        XCTAssertEqual(desiredIndexPath, indexPath)
    }

}
