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

open class BaseViewController: UIViewController {

    // MARK: - Properties

//    public var originalYOffset = CGFloat(0)
    open var stringsBundle: Bundle?
//    public var textFieldNavigationToolbar: TextFieldNavigationToolBar?
//    var keyboardHeight: CGFloat = 0


    // MARK: - Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.translateUI()
//        self.setupTextFieldNavigationToolBar()
    }

//    public func setupTextFieldNavigationToolBar() {
//        let textFields = self.fetchAllTextFields()
//        let toolBar = TextFieldNavigationToolBar(withTextFields: textFields, usingRelatedFields: nil)
//        toolBar.selectedTextField = nil
//        self.textFieldNavigationToolbar = toolBar
//    }
    
//    public func updateFieldsInToolBar() {
//        let textFields = self.fetchAllTextFields()
//        if let toolbar = self.textFieldNavigationToolbar {
//            toolbar.textFields = textFields
//        }
//    }
    
//    override public func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.registerForKeyboardNotifications()
//    }

//    override public func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        self.originalYOffset = self.view.frame.origin.y
//    }

//    override public func viewWillDisappear(animated: Bool) {
//        self.deregisterFromKeyboardNotifications()
//        super.viewWillDisappear(animated)
//    }


    // MARK: - Internationalization Support

    open func viewControllerTitle() -> String? { return nil }

    open func translateUI() {

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

    open func bundleForMessages() -> Bundle {
        var bundle: Bundle!
        if let stringBundle = self.stringsBundle {
            bundle = stringBundle
        } else {
            bundle = Bundle.main
        }
        return bundle
    }

    open func localizedBundleString(_ key: String) -> String {
        let bundle = self.bundleForMessages()
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }


    // MARK: - Keyboard Handling

//    public func fetchAllTextFields() -> [UITextField] {
//        var viewController = self
//        if let topMostViewController = self.topMostViewController(BaseViewController.self, startFromViewController: self) {
//            viewController = topMostViewController
//        }
//        return viewController.allViewFromClass(UITextField.self, onView: self.view).sort({ (leftTextField: UITextField, rightTextField: UITextField) -> Bool in
//            let leftScreenCoordinates = leftTextField.convertPoint(leftTextField.bounds.origin, toView: nil)
//            let rightScreenCoordinates = rightTextField.convertPoint(rightTextField.bounds.origin, toView: nil)
//            var returnValue = leftScreenCoordinates.y < rightScreenCoordinates.y
//            if leftScreenCoordinates.y == rightScreenCoordinates.y {
//                returnValue = leftScreenCoordinates.x < rightScreenCoordinates.x
//            }
//            return returnValue
//        })
//    }

//    public func firstResponder(textFields: [UITextField]) -> UITextField? {
//        return textFields.filter({ (textField: UITextField) -> Bool in
//            return textField.isFirstResponder()
//        }).first
//    }

//    public func registerForKeyboardNotifications() {
//        let notificationCenter = NSNotificationCenter.defaultCenter()
//        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
//    }

//    public func deregisterFromKeyboardNotifications() {
//        let notificationCenter = NSNotificationCenter.defaultCenter()
//        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
//        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
//    }

//    public func getKeyboardHeight(fromNotification notification: NSNotification) -> CGFloat {
//        guard let info = notification.userInfo else { return 0 }
//        guard let kbFrameKey = info[UIKeyboardFrameBeginUserInfoKey] else { return 0 }
//
//        var kbRect = kbFrameKey.CGRectValue()
//        kbRect = self.view.convertRect(kbRect, fromView: nil)
//
//        return kbRect.size.height
//    }
    
//    public func keyboardWillShow(notification: NSNotification) {
//        self.keyboardHeight = self.getKeyboardHeight(fromNotification: notification)
//        self.updateFieldsInToolBar()
//        self.scrollViewToFirstResponder()
//    }

//    public func keyboardWillHide(notification: NSNotification) {
//        self.view.frame.origin.y = self.originalYOffset
//    }

//    public func scrollViewToFirstResponder() {
//        guard let toolBar = self.textFieldNavigationToolbar else { return }
//        guard let firstResponder = toolBar.selectedTextField else { return }
//
//        let keyboardHeight = self.keyboardHeight
//        let firstResponderAbsoluteOrigin = firstResponder.convertPoint(firstResponder.frame.origin, toView: nil)
//        let firstResponderHeight = firstResponder.frame.size.height
//        let firstResponderThresholdPoint = CGPoint(x: 0, y: firstResponderAbsoluteOrigin.y + firstResponderHeight + 8)
//
//        var visibleRect = self.view.frame
//        if let topMostViewController = self.topMostViewController() {
//            visibleRect = topMostViewController.view.frame
//        }
//
//        visibleRect.size.height -= keyboardHeight
//
//        if !CGRectContainsPoint(visibleRect, firstResponderThresholdPoint) {
//            let yPos = (firstResponderThresholdPoint.y - visibleRect.size.height)
//            self.view.frame.origin.y = yPos * -1
//        }
//    }

}
