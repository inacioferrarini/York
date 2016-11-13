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
import Foundation

public extension UIImage {

    public class func circularScaleAndCropImage(_ image: UIImage, frame: CGRect) -> UIImage {

        let size = CGSize(width: frame.size.width, height: frame.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()

        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let rectWidth = frame.size.width
        let rectHeight = frame.size.height

        let scaleFactorX = rectWidth / imageWidth
        let scaleFactorY = rectHeight / imageHeight

        let imageCenterX = rectWidth / 2
        let imageCenterY = rectHeight / 2

        let radius = rectWidth / 2

        if let context = context {
            context.beginPath()
            let center = CGPoint(x: imageCenterX, y: imageCenterY)
            context.addArc(center: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: false)
            context.closePath()
            context.clip()

            context.scaleBy (x: scaleFactorX, y: scaleFactorY)
        
            let myRect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
            image.draw(in: myRect)
        }
        
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedImage!
    }

    public class func imageFromColor(_ color: UIColor, withSize size: CGSize, withCornerRadius cornerRadius: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        UIGraphicsBeginImageContext(size)

        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        image?.draw(in: rect)

        image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image!
    }

    public class func maskedImageNamed(_ image: UIImage, color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, image.scale)

        let context = UIGraphicsGetCurrentContext()
        image.draw(in: rect)

        context?.setFillColor(color.cgColor)
        context?.setBlendMode(.sourceAtop)
        context?.fill(rect)

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }

}
