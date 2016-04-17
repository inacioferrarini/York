import UIKit

public class BaseDataBasedViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet public weak var courtain: UIView?
    
    
    // MARK: - Initialization
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performDataSyncIfNeeded()
    }
    
    
    // MARK: - Data Syncrhonization
    
    public func performDataSyncIfNeeded() {
        if self.shouldSyncData() {
            self.showCourtainView()
            self.performDataSync()
        }
    }
    
    public func dataSyncCompleted() {
        self.hideCourtainView()
    }
    
    public func showCourtainView() {
        if let courtain = self.courtain {
            courtain.hidden = false
        }
        self.view.userInteractionEnabled = false
    }
    
    public func hideCourtainView() {
        if let courtain = self.courtain {
            courtain.hidden = true
        }
        self.view.userInteractionEnabled = true
    }
    
    
    // MARK: - Child classes are expected to override these methods
    
    public func shouldSyncData() -> Bool {
        return self.appContext.syncRules.shouldPerformSyncRule(self.dynamicType.simpleClassName(), atDate: NSDate())
    }
    
    public func performDataSync() {
        self.dataSyncCompleted()
    }
    
}
