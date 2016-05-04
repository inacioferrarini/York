# Release Notes

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
