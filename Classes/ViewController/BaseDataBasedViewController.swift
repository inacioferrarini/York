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

    @IBOutlet public weak var courtain: UIView?


    // MARK: - Initialization

    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performDataSyncIfNeeded()
    }


    // MARK: - Data Syncrhonization

    public func performDataSyncIfNeeded() {
        if self.shouldSyncData() {
            self.showCourtainView()
            self.performDataSync()
        }
    }

    public func dataSyncCompleted() {
        self.hideCourtainView()
    }

    public func showCourtainView() {
        if let courtain = self.courtain {
            courtain.hidden = false
        }
        self.view.userInteractionEnabled = false
    }

    public func hideCourtainView() {
        if let courtain = self.courtain {
            courtain.hidden = true
        }
        self.view.userInteractionEnabled = true
    }


    // MARK: - Child classes are expected to override these methods

    public func shouldSyncData() -> Bool {
        return self.appContext.syncRules.shouldPerformSyncRule(self.dynamicType.simpleClassName(), atDate: NSDate())
    }

    public func performDataSync() {
        self.dataSyncCompleted()
    }

}