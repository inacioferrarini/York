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

open class TableViewArrayOfArrayDataSource<CellType: UITableViewCell, Type: Equatable>: ArrayOfArrayDataSource<Type>, UITableViewDataSource {


    // MARK: - Properties

    open let tableView: UITableView
    open fileprivate(set) var presenter: TableViewCellPresenter<CellType, Type>
    open var titleForHeaderInSectionBlock: ((_ section: Int) -> String?)?


    // MARK: - Initialization

    public init(targetingTableView tableView: UITableView,
                                   presenter: TableViewCellPresenter<CellType, Type>,
                                   objects: [[Type]]) {

        self.tableView = tableView
        self.presenter = presenter

        super.init(objects: objects)
    }


    // MARK: - Public Methods

    open override func refreshData() {
        super.refreshData()
        self.tableView.reloadData()
    }


    // MARK: - Table View Data Source

open func numberOfSections(in tableView: UITableView) -> Int {
    return self.objects.count
}

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < self.objects.count else { return 0 }
        return self.objects[section].count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let value = self.objectAtIndexPath(indexPath)
        let reuseIdentifier = self.presenter.cellReuseIdentifierBlock(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType
        if let cell = cell,
            let value = value {
            self.presenter.configureCellBlock(cell, value)
        }
        return cell!
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let titleBlock = self.titleForHeaderInSectionBlock {
            return titleBlock(section)
        }
        return nil
    }

    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let editRowBlock = self.presenter.canEditRowAtIndexPathBlock {
            return editRowBlock(indexPath)
        }
        return false
    }

    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let commitEditingBlock = self.presenter.commitEditingStyleBlock {
            commitEditingBlock(editingStyle, indexPath)
        }
    }

//    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if let heightForHeaderInSectionBlock = self.presenter.heightForHeaderInSectionBlock {
//            return heightForHeaderInSectionBlock(section)
//        }
//        return 0
//    }

//    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if let heightForFooterInSectionBlock = self.presenter.heightForFooterInSectionBlock {
//            return heightForFooterInSectionBlock(section)
//        }
//        return 0
//    }

//    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if let viewForHeaderInSectionBlock = self.presenter.viewForHeaderInSectionBlock {
//            return viewForHeaderInSectionBlock(section)
//        }
//        return nil
//    }
//
//    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if let viewForFooterInSectionBlock = self.presenter.viewForFooterInSectionBlock {
//            return viewForFooterInSectionBlock(section)
//        }
//        return nil
//    }

}
