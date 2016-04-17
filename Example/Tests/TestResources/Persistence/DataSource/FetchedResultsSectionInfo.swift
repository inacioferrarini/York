import UIKit
import CoreData

class FetchedResultsSectionInfo: NSObject, NSFetchedResultsSectionInfo {
    
    let numberOfObjects: Int
    let objects: [AnyObject]?
    let name: String
    let indexTitle: String?
    
    init(numberOfObjects: Int, objects: [AnyObject]?, name: String, indexTitle: String?) {
        self.numberOfObjects = numberOfObjects
        self.objects = objects
        self.name = name
        self.indexTitle = indexTitle
        super.init()
    }
    
}
