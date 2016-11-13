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

public struct StaticTableViewStructure {

    public var structureUid: String
    public var height: CGFloat?
    public var cellReuseIdentifier: String
    public var configureCellBlock: ((_ cell: UITableViewCell, _ structure: StaticTableViewStructure) -> Void)?

    public init(structureUid: String, cellReuseIdentifier: String) {
        self.init(structureUid: structureUid, height: nil, cellReuseIdentifier: cellReuseIdentifier, configureCellBlock: nil)
    }

    public init(structureUid: String, cellReuseIdentifier: String, configureCellBlock: @escaping ((_ cell: UITableViewCell, _ structure: StaticTableViewStructure) -> Void)) {
        self.init(structureUid: structureUid, height: nil, cellReuseIdentifier: cellReuseIdentifier, configureCellBlock: configureCellBlock)
    }

    public init(structureUid: String,
                height: CGFloat?,
                cellReuseIdentifier: String,
                configureCellBlock: ((_ cell: UITableViewCell, _ structure: StaticTableViewStructure) -> Void)?) {
        self.structureUid = structureUid
        self.height = height
        self.cellReuseIdentifier = cellReuseIdentifier
        self.configureCellBlock = configureCellBlock
    }

}


// MARK: - Equatable

extension StaticTableViewStructure: Equatable {}

public func == (lhs: StaticTableViewStructure, rhs: StaticTableViewStructure) -> Bool {
    return lhs.structureUid == rhs.structureUid
}
