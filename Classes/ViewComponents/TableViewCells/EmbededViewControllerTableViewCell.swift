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

    public var embededViewController: UIViewController?


    // MARK: - Public Methods

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
