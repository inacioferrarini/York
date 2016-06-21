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

public class EmbededViewControllerTableViewCell: UITableViewCell {


    // MARK: - Properties

    public var embededViewController: UIViewController?   // -> EmbededViewController


    // Outlets

    @IBOutlet public weak var embededContentHeightConstraint: NSLayoutConstraint?


    // MARK: - Public Methods

    func getExistingHeightConstraint(fromView view: UIView) -> NSLayoutConstraint? {
        var desiredLayout: NSLayoutConstraint?
        for c in view.constraints {
            if c.instanceSimpleClassName() == "NSLayoutConstraint" && c.firstAttribute == .Height {
                desiredLayout = c
                break
            }
        }
        return desiredLayout
    }

    func createHeightConstraint(forView view:UIView) -> NSLayoutConstraint? {
        let bindingDic = ["firstView" : view]
        let constraint = NSLayoutConstraint.constraintsWithVisualFormat("V:[firstView(300)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindingDic)
        print ("createHeightConstraint")
        return nil
    }

    public func setupHeightConstraints() {
        if let firstView = self.contentView.subviews.first {
            if let heightConstraint = self.getExistingHeightConstraint(fromView: firstView) {
                print ("I've found the height constraint ... using this")
                self.embededContentHeightConstraint = heightConstraint
            } else {
print ("I'vent found the height constraint ... creating one")
self.embededContentHeightConstraint = self.createHeightConstraint(forView: firstView)
                if let constraint = self.embededContentHeightConstraint {
                    firstView.addConstraint(constraint)
                }
            }
        }
    }

    public func embedInParentViewController(parentViewController: UIViewController) {
        if let embededViewController = self.embededViewController {
            parentViewController.addChildViewController(embededViewController)
            embededViewController.didMoveToParentViewController(parentViewController)
            self.contentView.addSubview(embededViewController.view)
        }
    }

    public func unEmbedFromParentViewController() {
        if let embededViewController = self.embededViewController {
            embededViewController.view.removeFromSuperview()
            embededViewController.willMoveToParentViewController(nil)
            embededViewController.removeFromParentViewController()
        }
    }

}
