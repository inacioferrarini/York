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

open class BaseDataBasedViewController: BaseViewController {


    // MARK: - Properties

    @IBOutlet open weak var courtainView: UIView?


    // MARK: - Initialization

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.performDataSync()
    }


    // MARK: - Data Syncrhonization

    open func performDataSync() {
        if self.shouldSyncData() {
            let queue = DispatchQueue(label: self.instanceSimpleClassName(), attributes: [])
            queue.async(execute: {
                self.willSyncData()
                self.syncData()
                self.didSyncData()
            })
        } else {
            self.hideCourtainView()
        }
    }

    open func showCourtainView() {
        DispatchQueue.main.async {
            if let courtainView = self.courtainView {
                courtainView.isHidden = false
            }
        }
    }

    open func hideCourtainView() {
        DispatchQueue.main.async {
            if let courtainView = self.courtainView {
                courtainView.isHidden = true
            }
        }
    }


    // MARK: - Child classes are expected to override these methods

    open func shouldSyncData() -> Bool {
        return true
    }

    open func willSyncData() {
        self.showCourtainView()
    }

    open func syncData() {
    }

    open func didSyncData() {
        self.hideCourtainView()
    }

}
