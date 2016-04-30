# Release Notes

## 0.3.0
* Added more badges to README.md
* Replaced Cocoa Lumberjack as Log Provider in favor of XCGLogger, since XCGLogger is more adherent to Swift 2.2
* CoreDataStack
  * Added an ErrorHandler, provided by the user, allowing the user to define how CoreData errors will be handled. A default one is provided to keep the behaviour consistent with previous versions.
  * Simplified refreshData. It no longer throws exceptions, using the ErrorHandler instead.
* Included Uncrustify in the build process.
* Schema Navigation improved, allowing easier usage of modal presentation or traditional push transition.
