import UIKit

public class AppContext: NSObject {
    
    public let navigationController: UINavigationController
    public let coreDataStack: CoreDataStack
    public let syncRules: DataSyncRules
    public let router: NavigationRouter
    public let logger: Logger
    
    public init(navigationController: UINavigationController, coreDataStack: CoreDataStack, syncRules: DataSyncRules, router: NavigationRouter, logger: Logger) {
        self.navigationController = navigationController
        self.coreDataStack = coreDataStack
        self.syncRules = syncRules
        self.router = router
        self.logger = logger
        super.init()
    }
    
}
