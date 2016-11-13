# York
[![Version](https://img.shields.io/cocoapods/v/York.svg?style=flat)](http://cocoapods.org/pods/York)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-green.svg?style=flat)](https://swift.org/)
[![License](https://img.shields.io/cocoapods/l/York.svg?style=flat)](http://cocoapods.org/pods/York)
[![codecov.io](https://codecov.io/github/inacioferrarini/York/coverage.svg?branch=master)](https://codecov.io/github/inacioferrarini/York)

[![CI Status](http://img.shields.io/travis/inacioferrarini/York.svg?style=flat)](https://travis-ci.org/inacioferrarini/York)
[![Platform](https://img.shields.io/cocoapods/p/York.svg?style=flat)](http://cocoapods.org/pods/York)


### What is it?

York is a set of classes, that can be used together or not.
Every class has one responsibility and one responsibility only, being fully adherent to S.O.L.I.D. principles.


### Goals

* Eliminate Singleton usage (you don't need it)
* Dramatically reduce ViewControllers' size.
* Provide a block-based approach to common situations.
* Provide an easy project startup and reduce project startup time.
* Through the usage of a well designed base classes, provide a standard that will keep the project as standardized as possible.


### Structure

In order to make easier to understand every class role, they were grouped together:
* Context: Essentially, a way I found to avoid Singleton usage by injecting the App's Context.
* DataSyncRules: A basic time rule engine used to handle data synchronization gracefully and without hassle.
* DeepLinkingNavigation: Abstracts JLRoutes's usage for scheme-based navigation.
* Extensions: Basic extensions for common usage of UIKit and other classes.
* Logging: Abstracts CocoaLumberJack's usage for logging.
* Persistence: Contains the CoreDataStack, which handles boiler-plate code for CoreData, and a UITableViewDataSource based on CoreData and NSFetchedResultsController, which avoids NSFetchedResultsController boiler-plate code to be placed at the TableViewController.  
* Presenter: Classes used to handle how TableViewCells will be presented.
* TableViewDelegate: UITableViewDelegate alternative implementations, using blocks to handle used interaction events.
* ViewController: View Controllers implementations, supporting internationalization out of the box, data synchronization and Table View Implementations.
  * BaseViewController: The simplest UIViewController supporting internationalization out of the box.
  * BaseDataBasedViewController: Adds data synchronization capabilities to BaseViewController.
  * BaseTableViewController: Adds TableViewController capabilities to BaseDataBasedViewController. Allows the ViewController itself to be the Delegate or/and DataSource of the TableView, or, using the proper method, return the Delegate or/and DataSource to be used.
* ViewController: Basic class for Xib-based view components.


## Requirements

* iOS 8.0+


## Backwards Compatibility

* York version 0.4.0 for Swift 3.0
* York version 0.3.6 for Swift 2.2


## Last Version (0.4.0) Release Notes:

* Migrated to Swift 3.

All release notes are grouped here: (https://github.com/inacioferrarini/York/blob/master/ReleaseNotes.md)


## Installation

York is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "York"
```


## Author

Inácio Ferrarini, inacio.ferrarini@gmail.com


## License

The MIT License (MIT)

Copyright (c) 2016 Inácio Ferrarini

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
