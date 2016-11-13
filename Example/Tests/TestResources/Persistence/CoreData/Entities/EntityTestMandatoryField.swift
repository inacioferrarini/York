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

import Foundation
import CoreData
import York

open class EntityTestMandatoryField: NSManagedObject {

    open class func fetchEntityTestMandatoryField(_ name: String, inManagedObjectContext context: NSManagedObjectContext) -> EntityTestMandatoryField? {
        let request: NSFetchRequest = NSFetchRequest<EntityTestMandatoryField>(entityName: self.simpleClassName())
        request.predicate = NSPredicate(format: "name = %@", name)
        return self.lastObjectFromRequest(request, inManagedObjectContext: context)
    }

    open class func entityTestMandatoryField(_ name: String, inManagedObjectContext context: NSManagedObjectContext) -> EntityTestMandatoryField? {
        var entityTest: EntityTestMandatoryField? = self.fetchEntityTestMandatoryField(name, inManagedObjectContext: context)
        if entityTest == nil {
            let newEntityTest = NSEntityDescription.insertNewObject(forEntityName: self.simpleClassName(), into: context) as? EntityTestMandatoryField
            if let entity = newEntityTest {
                entity.name = name
            }
            entityTest = newEntityTest
        }
        return entityTest
    }

}
