# Release Notes

## 0.3.0
* Added more badges to README.md
* Added LogProvider protocol, allowing the user to use any logging framework he wants, and allowing all York-based classes to use the same logging framework and configuration.
* CoreDataStack
  * Added an ErrorHandler, provided by the user, allowing the user to define how CoreData errors will be handled. A default one is provided to keep the behaviour consistent with previous versions.
  * Simplified refreshData. It no longer throws exceptions, using the ErrorHandler instead.
* Included Uncrustify in the build process.
* Schema Navigation improved, allowing easier usage of modal presentation or traditional push transition.
