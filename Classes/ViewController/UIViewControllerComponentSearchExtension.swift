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
        guard let window = UIApplication.shared.keyWindow else { return nil }
        guard var topMostViewController = window.rootViewController else { return nil }

        while nil != topMostViewController.presentedViewController {
            guard let currentVC = topMostViewController.presentedViewController else { return topMostViewController }
            topMostViewController = currentVC
        }
        return topMostViewController
    }

    public func topMostViewController<T>(_ targetClass: T.Type, startFromViewController viewController: UIViewController) -> T? where T : UIViewController {
        var targetViewController: T?
        if let viewController = viewController as? T {
            targetViewController = viewController
        }
        var currentViewController = viewController
        while nil != currentViewController.parent {
            if let viewController = viewController as? T {
                targetViewController = viewController
            }
            if let parentViewController = currentViewController.parent {
                currentViewController = parentViewController
            }
        }
        return targetViewController
    }

    public func allViewFromClass<T>(_ targetClass: T.Type, onView rootView: UIView) ->  [T] where T : UIView {
        var elements = [T]()
        for subview in rootView.subviews {
            if let subview = subview as? T {
                elements.append(subview)
            }
            if subview.subviews.count > 0 {
                elements.append(contentsOf: self.allViewFromClass(targetClass, onView: subview))
            }
        }
        return elements
    }

    public func subviewFromClass<T>(_ targetClass: T.Type, onView rootView: UIView, withAccessibilityIdentifier accessibilityIdentifier: String) ->  T? where T : UIView {
        var view: T?
        for subview in rootView.subviews {
            if let subview = subview as? T, subview.accessibilityIdentifier == accessibilityIdentifier {
                view = subview
                break
            }
            if subview.subviews.count > 0 {
                if let subview = self.subviewFromClass(targetClass, onView: subview, withAccessibilityIdentifier: accessibilityIdentifier) {
                    view = subview
                    break
                }
            }
        }
        return view
    }

    public func findButton(withAccessibilityIdentifier accessibilityIdentifier: String) -> UIButton? {
        var viewController = self
        if let topMostViewController = self.topMostViewController(BaseViewController.self, startFromViewController: self) {
            viewController = topMostViewController
        }
        return viewController.subviewFromClass(UIButton.self, onView: self.view, withAccessibilityIdentifier: accessibilityIdentifier)
    }

    public func findTextField(withAccessibilityIdentifier accessibilityIdentifier: String) -> UITextField? {
        var viewController = self
        if let topMostViewController = self.topMostViewController(BaseViewController.self, startFromViewController: self) {
            viewController = topMostViewController
        }
        return viewController.subviewFromClass(UITextField.self, onView: self.view, withAccessibilityIdentifier: accessibilityIdentifier)
    }

    public func findLabel(withAccessibilityIdentifier accessibilityIdentifier: String) -> UILabel? {
        var viewController = self
        if let topMostViewController = self.topMostViewController(BaseViewController.self, startFromViewController: self) {
            viewController = topMostViewController
        }
        return viewController.subviewFromClass(UILabel.self, onView: self.view, withAccessibilityIdentifier: accessibilityIdentifier)
    }

    public func findImageView(withAccessibilityIdentifier accessibilityIdentifier: String) -> UIImageView? {
        var viewController = self
        if let topMostViewController = self.topMostViewController(BaseViewController.self, startFromViewController: self) {
            viewController = topMostViewController
        }
        return viewController.subviewFromClass(UIImageView.self, onView: self.view, withAccessibilityIdentifier: accessibilityIdentifier)
    }

    public func findView(withAccessibilityIdentifier accessibilityIdentifier: String) -> UIView? {
        var viewController = self
        if let topMostViewController = self.topMostViewController(BaseViewController.self, startFromViewController: self) {
            viewController = topMostViewController
        }
        return viewController.subviewFromClass(UIView.self, onView: self.view, withAccessibilityIdentifier: accessibilityIdentifier)
    }

}
