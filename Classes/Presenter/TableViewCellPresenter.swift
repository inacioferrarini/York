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
import CoreData

open class TableViewCellPresenter<CellType: UITableViewCell, ValueType: Any>: NSObject {

    open var configureCellBlock: ((CellType, ValueType) -> Void)
    open var cellReuseIdentifierBlock: ((_ indexPath: IndexPath) -> String)
    open var canEditRowAtIndexPathBlock: ((_ indexPath: IndexPath) -> Bool)?
    open var commitEditingStyleBlock: ((_ editingStyle: UITableViewCellEditingStyle, _ forRowAtIndexPath: IndexPath) -> Void)?

//    open var heightForHeaderInSectionBlock: ((_ section: NSInteger) -> CGFloat)?
//    open var heightForFooterInSectionBlock: ((_ section: NSInteger) -> CGFloat)?
//    open var viewForHeaderInSectionBlock: ((_ section: NSInteger) -> UIView?)?
//    open var viewForFooterInSectionBlock: ((_ section: NSInteger) -> UIView?)?

    public init(configureCellBlock: @escaping ((CellType, ValueType) -> Void), cellReuseIdentifierBlock: @escaping ((_ indexPath: IndexPath) -> String)) {
        self.configureCellBlock = configureCellBlock
        self.cellReuseIdentifierBlock = cellReuseIdentifierBlock
        super.init()
    }

}
