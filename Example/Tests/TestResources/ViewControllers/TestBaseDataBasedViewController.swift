import UIKit
import York

class TestBaseDataBasedViewController: BaseDataBasedViewController {
    
    override func shouldSyncData() -> Bool {
        return true
    }
    
}
