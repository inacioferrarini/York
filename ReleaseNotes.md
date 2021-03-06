# Release Notes

## 0.4.0
* Migrated to Swift 3. First version compatible with Swift 3.

## 0.3.6
* Renaming:
 * ViewComponents/TableViewCells/EmbededViewControllerTableViewCell renamed to EmbeddedViewControllerTableViewCell.
* Minor Bugfixes. Last version compatible with Swift 2.2.

## 0.3.3
* New Features:
  * DataSources:
    * Added ArrayDataSource for providing arrays as DataSources to Views.
    * Added TableViewArrayDataSource for providing arrays as DataSources to UITableViews.
    * Added CollectionViewArrayDataSource for providing arrays as DataSources to UICollectionViews.
    * Added CollectionViewTableViewCell for providing a TableViewCell that contains an UICollectionView, having as well the UICollectionViewDetaSource.
  * Collections:
    * Added Stack collection type.
  * Extensions:
    * Added StringExtensions, providing string related methods.
    * Added UIViewExtensions, providing useful methods for handling border width, maskToBounds and border color as IBDesignable.
    * Added method to return the class name from the current instance to NSObjectExtension.
  * FlowCoordinator:
    * Added FlowContext, FlowCoordinator, FlowElement and FlowStatus, to abstract flow coordination.
  * Networking:
    * Added HttpCookieManager to handle http session cookies.
  * StaticContent:
    * Added StaticTableViewStructure to handle static table view structures.
  * Transform:
    * Added Transformer protocol.
  * ViewController:
    * Added BaseTabBarController to handle UITabBar customizations.
    * Added BaseCollectionViewController as a base class for collection view base class.
  * ViewDelegates:
    * Added TableViewBlockDelegate for handling UITableView item selection and related events.
    * Added CollectionViewBlockDelegate for handling UICollectionView item selection and related events.
  * ViewComponents:
    * Added EmbededViewControllerTableViewCell, allowing to embed a UIViewController inside a TableViewCell with ease.
    * Added CollectionViewColumnLayout, allowing to have a collection view with columns.
  * Views:
    * Added DesignableView for basic views that must be '@IBDesignable'

* Updates
  * Context:
    * DataSources
      * Arrays
        * ArrayDataSource: Updated ArrayDataSource and variants to use Equatable instead of AnyObject, allowing any equatable object can be used.
        * CollectionViewArrayDataSource: Updated ArrayDataSource and variants to use Equatable instead of AnyObject, allowing any equatable object can be used.
        * TableViewArrayDataSource:
          * Updated ArrayDataSource and variants to use Equatable instead of AnyObject, allowing any equatable object can be used.
          * Added titleForHeaderInSection support.
      * CoreData
        * TableViewFetcherDataSource:
          * Added titleForHeaderInSection support.
  * Context:
    * AppContextAwareProtocol: Made generic. Now any Structure or Class can be used as AppContext, allowing any project to have an AppContext created to better suit the project requirements.
    * AppContext: Due to changes in AppContextAwareProtocol, AppContext is no longer essential. Besides that, it was kept inside York, being renamed to FullStackAppContext.
  * DeepLinkingNavigation:
    * PresentationPath: added a replacingValues method variant that only takes mode as parameter, for url without parameters. replacingValues:values:mode nows allows nil to be supplied as values.
  * Extensions:
    * UIImageExtension: Added utility methods imageFromColor and maskedImageNamed
  * Presenter:
    * CollectionViewCellPresenter:
      * changed EntityType parameter from NSManagedObject to AnyObject, allowing it to be used by CollectionViewArrayDataSources as well.
      * "EntityType" parameter renamed to "ValueType". Changed from AnyObject to Any to better support swift types.
    * TableViewCellPresenter:
      * changed EntityType parameter from NSManagedObject to AnyObject, allowing it to be used by TableViewArrayDataSources as well.
      * "EntityType" parameter renamed to "ValueType". Changed from AnyObject to Any to better support swift types.
  * TableViewCells:
    * CollectionViewTableViewCell: Added delegate property.
  * ViewControllers:
    * BaseViewController: Updated due to AppContextAwareProtocol changes.
    * BaseDataBasedViewController:
      * Updated due to AppContextAwareProtocol changes.
      * Updated Data sync structure. Now, performDataSyncIfNeeded() was renamed to performDataSync(), which will check shouldSyncData(). If shouldSyncData() returns true, in order, willSyncData(), syncData() and and then didSyncData() will be executed. willSyncData() is used to pre-processing (example: display a curtain, etc), while didSyncData() is used to post-processing (example: hide a curtain, etc).
    * BaseTableViewController:
      * Updated due to AppContextAwareProtocol changes.
      * Updated Data sync structure. Now, performDataSyncIfNeeded() was renamed to performDataSync(), which will check shouldSyncData(). If shouldSyncData() returns true, in order, willSyncData(), syncData() and and then didSyncData() will be executed. willSyncData() is used to pre-processing (example: display a curtain, etc), while didSyncData() is used to post-processing (example: hide a curtain, etc).
      * UIRefreshControl is no longer created by default. If createRefreshControl is overriden and returns a non-nill object, it will be added to the table view.
  * ViewDelegates
    * TableViewDelegate module renamed to 'ViewDelegates' in order to better support other view delegates.  
    * TableViewBlockDelegate added var heightForRowAtIndexPathBlock to allow TableViewCells with different heights. If not defined, will return UITableViewAutomaticDimension value.

* Bug Fixes
  * Removed viewDidAppear method. It was doing the same thing as DataBasedViewController, thus, duplicating performDataSyncIfNeeded.


## 0.3.2
* Updated AppContext to keep reference to multiple View Controllers instead of only one UINavigationController.
This is an intended change in order to make York usable for Apps using a UITabBarController or any other configuration that does not have a "main" UINavigationController.


## 0.3.1
* Minor improvements
* Updated unit tests
* Fixed path to all release notes


## 0.3.0
* Added more badges to README.md
* Added LogProvider protocol, allowing the user to use any logging framework he wants, and allowing all York-based classes to use the same logging framework and configuration.
* CoreDataStack
  * Simplified refreshData. It no longer throws exceptions, using the ErrorHandler instead.
* Schema Navigation improved, allowing easier usage of modal presentation or traditional push transition.
