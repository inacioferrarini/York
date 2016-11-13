//    The MIT License (MIT)
//
//    Copyright (c) 2016 Inácio Ferrarini
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import CoreData

open class CoreDataStack: NSObject {

    open let modelFileName: String
    open let databaseFileName: String
    open let logger: Logger
    open let bundle: Bundle?

    public init(modelFileName: String, databaseFileName: String, logger: Logger, bundle: Bundle?) {
        self.modelFileName = modelFileName
        self.databaseFileName = databaseFileName
        self.logger = logger
        self.bundle = bundle
        super.init()
    }

    public convenience init(modelFileName: String, databaseFileName: String, logger: Logger) {
        self.init(modelFileName: modelFileName, databaseFileName: databaseFileName, logger:logger, bundle: nil)
    }

    open lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    open lazy var managedObjectModel: NSManagedObjectModel = {
        var modelURL: URL!
        if let bundle = self.bundle {
            modelURL = bundle.url(forResource: self.modelFileName, withExtension: "momd")!
        } else {
            modelURL = Bundle.main.url(forResource: self.modelFileName, withExtension: "momd")!
        }
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    open lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("\(self.databaseFileName).sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let isRunningUnitTests = NSClassFromString("XCTest") != nil
            let storeType = isRunningUnitTests ? NSInMemoryStoreType : NSSQLiteStoreType
            try coordinator.addPersistentStore(ofType: storeType, configurationName: nil, at: url, options: nil)
        } catch let error as NSError {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            self.logger.logError(wrappedError)
        }
        return coordinator
    }()

    open lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()


    // MARK: - Core Data Saving support

    open func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                self.logger.logError(error)
            }
        }
    }

}
