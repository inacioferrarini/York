import UIKit

public class BaseViewController: UIViewController, AppContextAwareProtocol {

    // MARK: - Properties
    
    public var appContext: AppContext!
    
    
    // MARK: - Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.translateUI()
    }
    
    
    // MARK: - i18n
    
    public func viewControllerTitle() -> String? { return nil }
    
    public func translateUI() {
        
        if let title = self.viewControllerTitle() {
            self.navigationItem.title = title
        }
                
        for view in self.view.subviews as [UIView] {
            if let label = view as? UILabel {
                if let identifier = label.accessibilityIdentifier {
                    let text = localizedBundleString(identifier)
                    if (text == identifier) {
                        self.appContext.logger.logErrorMessage("Missing string for \(identifier)")
                    } else {
                        label.text = text
                    }
                }
            }
        }
        
    }
    
    public func localizedBundleString(key: String) -> String {
        let bundle = NSBundle(forClass: self.dynamicType)
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
}
