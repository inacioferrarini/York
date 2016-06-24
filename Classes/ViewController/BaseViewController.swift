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

public class BaseViewController: UIViewController {

    // MARK: - Properties

    public var originalYOffset = CGFloat(0)
    public var stringsBundle: NSBundle?


    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.translateUI()
    }

    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }

    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.originalYOffset = self.view.frame.origin.y
    }

    override public func viewWillDisappear(animated: Bool) {
        self.deregisterFromKeyboardNotifications()
        super.viewWillDisappear(animated)
    }


    // MARK: - Internationalization Support

    public func viewControllerTitle() -> String? { return nil }

    public func translateUI() {

        if let title = self.viewControllerTitle() {
            self.navigationItem.title = title
        }

        for view in self.view.subviews as [UIView] {
            if let label = view as? UILabel {
                if let identifier = label.accessibilityIdentifier {
                    let text = localizedBundleString(identifier)
                    if text == identifier {
                        // self.appContext.logger.logErrorMessage("Missing string for \(identifier)")
                    } else {
                        label.text = text
                    }
                }
            }
        }

    }

    public func bundleForMessages() -> NSBundle {
        var bundle: NSBundle!
        if let stringBundle = self.stringsBundle {
            bundle = stringBundle
        } else {
            bundle = NSBundle.mainBundle()
        }
        return bundle
    }

    public func localizedBundleString(key: String) -> String {
        let bundle = self.bundleForMessages()
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }


    // MARK: - Keyboard Handling

    public func fetchAllTextFields() -> [UITextField] {
        return self.allViewFromClass(UITextField.self, onView: self.view).sort({ (leftTextField: UITextField, rightTextField: UITextField) -> Bool in
            let leftScreenCoordinates = leftTextField.convertPoint(leftTextField.bounds.origin, toView: nil)
            let rightScreenCoordinates = rightTextField.convertPoint(rightTextField.bounds.origin, toView: nil)
            var returnValue = leftScreenCoordinates.y < rightScreenCoordinates.y
            if leftScreenCoordinates.y == rightScreenCoordinates.y {
                returnValue = leftScreenCoordinates.x < rightScreenCoordinates.x
            }
            return returnValue
        })
    }

    public func firstResponder(textFields: [UITextField]) -> UITextField? {
        return textFields.filter({ (textField: UITextField) -> Bool in
            return textField.isFirstResponder()
        }).first
    }
    
    public func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }

    public func deregisterFromKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    public func getKeyboardHeight(fromNotification notification: NSNotification) -> CGFloat {
        guard let info = notification.userInfo else { return 0 }
        guard let kbFrameKey = info[UIKeyboardFrameBeginUserInfoKey] else { return 0 }

        var kbRect = kbFrameKey.CGRectValue()
        kbRect = self.view.convertRect(kbRect, fromView: nil)

        return kbRect.size.height
    }
    
    public func keyboardWillShow(notification: NSNotification) {
        let textFields = self.fetchAllTextFields()
        guard let firstResponder = self.firstResponder(textFields) else { return }

        let keyboardHeight = self.getKeyboardHeight(fromNotification: notification)
        let firstResponderOrigin = firstResponder.convertPoint(self.view.frame.origin, toView: nil)
        let firstResponderHeight = firstResponder.frame.size.height
//print("firstResponderOrigin: (\(firstResponderOrigin.x), \(firstResponderOrigin.y))")
//print("firstResponderHeight: \(firstResponderHeight)")
        var visibleRect = self.view.frame
//print("visibleRect: (\(visibleRect.origin.x), \(visibleRect.origin.y), \(visibleRect.size.width), \(visibleRect.size.height))")
        visibleRect.size.height -= keyboardHeight
//print("visibleRect: (\(visibleRect.origin.x), \(visibleRect.origin.y), \(visibleRect.size.width), \(visibleRect.size.height))")
        
        if !CGRectContainsPoint(visibleRect, firstResponderOrigin) {
            let yPos = firstResponderOrigin.y - visibleRect.size.height + firstResponderHeight + 8
            let scrollPoint = CGPoint(x: 0.0, y: -1 * yPos)
            self.view.frame.origin.y = scrollPoint.y
        }
    }

    public func keyboardWillHide(notification: NSNotification) {
//print ("original y offset: \(self.originalYOffset)")
        self.view.frame.origin.y = self.originalYOffset
    }

}
