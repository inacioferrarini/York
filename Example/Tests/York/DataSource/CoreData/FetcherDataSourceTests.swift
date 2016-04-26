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

import XCTest
import CoreData
import York

class FetcherDataSourceTests: BaseFetcherDataSourceTests {

    
    // MARK: - Supporting Methods
    
    func createFetcherDataSourceConvenienceInitializer() -> FetcherDataSource<EntityTest> {
        self.entityName = EntityTest.simpleClassName()
        self.sortDescriptors = []
        self.coreDataStack = TestUtil().testAppContext().coreDataStack
        self.managedObjectContext = self.coreDataStack.managedObjectContext
        self.logger = Logger()
        self.predicate = nil
        self.fetchLimit = nil
        self.sectionNameKeyPath = nil
        self.cacheName = nil
        
        let dataSource = FetcherDataSource<EntityTest>(entityName: self.entityName,
                                                       sortDescriptors: self.sortDescriptors,
                                                       managedObjectContext: self.managedObjectContext,
                                                       logger: self.logger)
        return dataSource
    }

    func createFetcherDataSourceDesignatedInitializer() -> FetcherDataSource<EntityTest> {
        self.entityName = EntityTest.simpleClassName()
        self.sortDescriptors = []
        self.coreDataStack = TestUtil().testAppContext().coreDataStack
        self.managedObjectContext = self.coreDataStack.managedObjectContext
        self.logger = Logger()
        self.predicate = nil
        self.fetchLimit = 100
        self.sectionNameKeyPath = nil
        self.cacheName = "cacheName"
        
        let dataSource = FetcherDataSource<EntityTest>(entityName: self.entityName,
                                                       sortDescriptors: self.sortDescriptors,
                                                       managedObjectContext: self.managedObjectContext,
                                                       logger: self.logger,
                                                       predicate: self.predicate,
                                                       fetchLimit: self.fetchLimit,
                                                       sectionNameKeyPath: self.sectionNameKeyPath,
                                                       cacheName: self.cacheName)
        return dataSource
    }
    
    
    // MARK: - Tests - Initialization With Convenience Initializer
    
    func test_convenienceInitializer_FetcherDataSourceFields_entityName() {
        let dataSource = self.createFetcherDataSourceConvenienceInitializer()
        XCTAssertEqual(dataSource.entityName, self.entityName)
    }
    
    func test_convenienceInitializer_FetcherDataSourceFields_predicate() {
        let dataSource = self.createFetcherDataSourceConvenienceInitializer()
        XCTAssertNil(dataSource.predicate)
    }

    func test_convenienceInitializer_FetcherDataSourceFields_fetchLimit() {
        let dataSource = self.createFetcherDataSourceConvenienceInitializer()
        XCTAssertNil(dataSource.fetchLimit)
    }
    
    func test_convenienceInitializer_FetcherDataSourceFields_sortDescriptors() {
        let dataSource = self.createFetcherDataSourceConvenienceInitializer()
        XCTAssertEqual(dataSource.sortDescriptors, self.sortDescriptors)
    }
    
    func test_convenienceInitializer_FetcherDataSourceFields_sectionNameKeyPath() {
        let dataSource = self.createFetcherDataSourceConvenienceInitializer()
        XCTAssertNil(dataSource.sectionNameKeyPath)
    }
    
    func test_convenienceInitializer_FetcherDataSourceFields_cacheName() {
        let dataSource = self.createFetcherDataSourceConvenienceInitializer()
        XCTAssertNil(dataSource.cacheName)
    }
    
    func test_convenienceInitializer_FetcherDataSourceFields_managedObjectContext() {
        let dataSource = self.createFetcherDataSourceConvenienceInitializer()
        XCTAssertEqual(dataSource.managedObjectContext, self.managedObjectContext)
    }
    
    func test_convenienceInitializer_FetcherDataSourceFields_logger() {
        let dataSource = self.createFetcherDataSourceConvenienceInitializer()
        XCTAssertEqual(dataSource.logger, self.logger)
    }
    
    
    // MARK: - Tests - Initialization With Designated Initializer
    
    func test_designatedInitializer_FetcherDataSourceFields_entityName() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        XCTAssertEqual(dataSource.entityName, self.entityName)
    }
    
    func test_designatedInitializer_FetcherDataSourceFields_predicate() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        XCTAssertEqual(dataSource.predicate, self.predicate)
    }
    
    func test_designatedInitializer_FetcherDataSourceFields_fetchLimit() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        XCTAssertEqual(dataSource.fetchLimit, self.fetchLimit)
    }
    
    func test_designatedInitializer_FetcherDataSourceFields_sortDescriptors() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        XCTAssertEqual(dataSource.sortDescriptors, self.sortDescriptors)
    }
    
    func test_designatedInitializer_FetcherDataSourceFields_sectionNameKeyPath() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        XCTAssertEqual(dataSource.sectionNameKeyPath, self.sectionNameKeyPath)
    }
    
    func test_designatedInitializer_FetcherDataSourceFields_cacheName() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        XCTAssertEqual(dataSource.cacheName, self.cacheName)
    }
    
    func test_designatedInitializer_FetcherDataSourceFields_managedObjectContext() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        XCTAssertEqual(dataSource.managedObjectContext, self.managedObjectContext)
    }
    
    func test_designatedInitializer_FetcherDataSourceFields_logger() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        XCTAssertEqual(dataSource.logger, self.logger)
    }
    
    
    // MARK: - Tests - refresh
    
    func test_FetcherDataSource_refresh_mustSucceed() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        dataSource.sortDescriptors = []
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_FetcherDataSource_refresh_mustIgnoreExceptionCrash() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "nonExistingField", ascending: true) ]
        dataSource.predicate = nil
        
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    
    // MARK: - Tests - objectAtIndexPath
    
    func test_FetcherDataSource_objectAtIndexPath_mustReturnEntity() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
        self.removeAllTestEntities()
        
        let entityTest0 = self.createTestEntity(nil, name: "EntityTest-0", order: 0)
        self.createTestEntity(nil, name: "EntityTest-1", order: 1)
        self.coreDataStack.saveContext()
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let entityAtIndexPath = dataSource.objectAtIndexPath(indexPath)
        XCTAssertEqual(entityAtIndexPath, entityTest0!)
    }
    
    
    // MARK: - Tests - indexPathForObject
    
    func test_FetcherDataSource_indexPathForObject_mustSucceed() {
        let dataSource = self.createFetcherDataSourceDesignatedInitializer()
        dataSource.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
        self.removeAllTestEntities()
        
        let entityTest0 = self.createTestEntity(nil, name: "EntityTest-0", order: 0)
        self.createTestEntity(nil, name: "EntityTest-1", order: 1)
        self.coreDataStack.saveContext()
        do {
            try dataSource.refreshData()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
        
        let entityIndexPath = dataSource.indexPathForObject(entityTest0!)!
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        XCTAssertEqual(entityIndexPath, indexPath)
    }
    
}
