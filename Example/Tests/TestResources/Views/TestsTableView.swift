import UIKit

class TestsTableView: UITableView {

    var cellForRowAtIndexPathBlock: (() -> UITableViewCell?)!
    
    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        return self.cellForRowAtIndexPathBlock()
        
    }

}
