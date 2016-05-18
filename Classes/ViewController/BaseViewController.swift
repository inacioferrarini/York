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

    public var stringsBundle: NSBundle?


    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.translateUI()
    }


    // MARK: - i18n

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

}
