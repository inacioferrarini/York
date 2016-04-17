import XCTest
import York

class UIImageExtensionTests: XCTestCase {

    func test_circularScaleAndCropImage_image() {
        var finalImage:UIImage?
        let bundle = NSBundle(forClass: self.dynamicType)
        if let image = UIImage(named: "default-avatar", inBundle: bundle, compatibleWithTraitCollection: nil) {
            finalImage = UIImage.circularScaleAndCropImage(image, frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        }
        XCTAssertNotNil(finalImage)
    }

}
