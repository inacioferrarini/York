import UIKit
import York

class TestBaseViewController: BaseViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewControllerTitle() -> String? {
        let bundle = TestUtil().unitTestsBundle()
        return NSLocalizedString("VC_TEST_BASE_VIEW_CONTROLLER", tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    override func bundleForMessages() -> NSBundle {
        return TestUtil().unitTestsBundle()
    }
    
}
