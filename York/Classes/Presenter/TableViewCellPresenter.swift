import UIKit
import CoreData

public class TableViewCellPresenter<CellType: UITableViewCell, EntityType: NSManagedObject>: NSObject {
    
    public var configureCellBlock:((CellType, EntityType) -> Void)
    public var cellReuseIdentifier:String
    public var canEditRowAtIndexPathBlock:((indexPath: NSIndexPath) -> Bool)?
    public var commitEditingStyleBlock:((editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath: NSIndexPath) -> Void)?
       
    public init(configureCellBlock:((CellType, EntityType) -> Void), cellReuseIdentifier:String) {
        self.configureCellBlock = configureCellBlock
        self.cellReuseIdentifier = cellReuseIdentifier
        super.init()
    }
    
}
