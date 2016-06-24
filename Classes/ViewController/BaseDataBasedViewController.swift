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

public class BaseDataBasedViewController: BaseViewController {


    // MARK: - Properties

    @IBOutlet public weak var courtainView: UIView?


    // MARK: - Initialization

    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performDataSync()
    }


    // MARK: - Data Syncrhonization

    public func performDataSync() {
        if self.shouldSyncData() {
            let queue = dispatch_queue_create(self.instanceSimpleClassName(), nil)
            dispatch_async(queue, {
                self.willSyncData()
                self.syncData()
                self.didSyncData()
            })
        } else {
            self.hideCourtainView()
        }
    }

    public func showCourtainView() {
        dispatch_async(dispatch_get_main_queue()) {
            if let courtainView = self.courtainView {
                courtainView.hidden = false
            }
        }
    }

    public func hideCourtainView() {
        dispatch_async(dispatch_get_main_queue()) {
            if let courtainView = self.courtainView {
                courtainView.hidden = true
            }
        }
    }


    // MARK: - Child classes are expected to override these methods

    public func shouldSyncData() -> Bool {
        return true
    }

    public func willSyncData() {
        self.showCourtainView()
    }

    public func syncData() {
    }

    public func didSyncData() {
        self.hideCourtainView()
    }

}
