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

open class ViewComponent: DesignableView {

    open let bundle: Bundle?

    public required init(frame: CGRect, bundle: Bundle?) {
        self.bundle = bundle
        super.init(frame: frame)
        self.load()
    }

    public required init?(coder aDecoder: NSCoder) {
        self.bundle = nil
        super.init(coder: aDecoder)
        self.load()
    }

    open func load() {
        let className = type(of: self).simpleClassName()
        var view: UIView!

        if let bundle = self.bundle {
            view = bundle.loadNibNamed(className, owner: self, options: nil)?.first as? UIView
        } else {
            view = Bundle(for: type(of: self)).loadNibNamed(className, owner: self, options: nil)?.first as? UIView
        }
        self.addSubview(view)
        view.frame = self.bounds
    }

}
