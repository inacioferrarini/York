import UIKit
import Foundation

extension UIImage {

    public class func circularScaleAndCropImage(image:UIImage, frame:CGRect) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(frame.size.width, frame.size.height), false, UIScreen.mainScreen().scale)
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
        
        CGContextBeginPath(context)
        CGContextAddArc(context, imageCenterX, imageCenterY, radius, 0, CGFloat(2 * M_PI), 0)
        CGContextClosePath(context)
        CGContextClip(context)
        
        CGContextScaleCTM (context, scaleFactorX, scaleFactorY)
        
        let myRect = CGRectMake(0, 0, imageWidth, imageHeight)
        image.drawInRect(myRect)

        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedImage
    }
    
}
