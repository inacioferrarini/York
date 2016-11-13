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

open class ArrayDataSource<Type: Equatable>: NSObject {


    // MARK: - Properties

    open var objects: [Type]


    // MARK: - Initialization

    public init(objects: [Type]) {
        self.objects = objects
    }


    // MARK: - Public Methods

    open func refreshData() {
    }

    open func objectAtIndexPath(_ indexPath: IndexPath) -> Type? {
        guard indexPath.section == 0 else { return nil }
        guard indexPath.row < self.objects.count else { return nil }
        return objects[indexPath.row]
    }

    open func indexPathForObject(_ object: Type) -> IndexPath? {
        var indexPath: IndexPath?
        if let index = self.objects.index(where: {$0 == object}) {
            indexPath = IndexPath(row: index, section: 0)
        }
        return indexPath
    }

}
