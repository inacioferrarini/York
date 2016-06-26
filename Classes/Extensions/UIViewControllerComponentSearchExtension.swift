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

public extension UIViewController {


    // MARK: - Component Search

    public func topMostViewController() -> UIViewController? {
        guard let window = UIApplication.sharedApplication().keyWindow else { return nil }
        guard var topMostViewController = window.rootViewController else { return nil }

        while nil != topMostViewController.presentedViewController {
            guard let currentVC = topMostViewController.presentedViewController else { return topMostViewController }
            topMostViewController = currentVC
        }
        return topMostViewController
    }
    
    public func allViewFromClass<T where T : UIView>(targetClass: T.Type, onView rootView: UIView) ->  [T] {
        var elements = [T]()
        for subview in rootView.subviews {
            if let subview = subview as? T {
                elements.append(subview)
            }
            if subview.subviews.count > 0 {
                elements.appendContentsOf(self.allViewFromClass(targetClass, onView: subview))
            }
        }
        return elements
    }

}
