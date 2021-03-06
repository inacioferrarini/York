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

class UIImageExtensionTests: XCTestCase {


    // MARK: - Tests

    func test_circularScaleAndCropImage_mustReturnImage() {
        var finalImage: UIImage?
        let bundle = TestUtil().unitTestsBundle()
        if let image = UIImage(named: "default-avatar", in: bundle, compatibleWith: nil) {
            finalImage = UIImage.circularScaleAndCropImage(image, frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        }
        XCTAssertNotNil(finalImage)
    }

    func test_imageFromColor_mustReturnImage() {
        let finalImage = UIImage.imageFromColor(UIColor.blue, withSize: CGSize(width: 10, height: 10), withCornerRadius: 1)
        XCTAssertNotNil(finalImage)
    }

    func test_maskedImageNamed_mustReturnImage() {
        var finalImage = UIImage.imageFromColor(UIColor.blue, withSize: CGSize(width: 10, height: 10), withCornerRadius: 1)
        finalImage = UIImage.maskedImageNamed(finalImage, color: UIColor.white)
        XCTAssertNotNil(finalImage)
    }

}
