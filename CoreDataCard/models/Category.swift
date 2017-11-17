//
//  Category.swift
//  CoreDataCard
//
//  Created by LIANG ZHAO on 2017-11-09.
//  Copyright © 2017 bcit. All rights reserved.
//

import UIKit
import CoreData
class Category: NSManagedObject {

    //create func
    class func CreateCategory(CategoryName: String, in context: NSManagedObjectContext) -> Category?
    {
        
        //query to check if the db had the name already
        //if so, return nil
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "categoryName = %@", argumentArray: [CategoryName])
        let object = try! context.fetch(fetchRequest)
        if(object.count >= 1) {
            print("duplicate data")
            return nil
        }
        
        //1: to get a new object(new row in db)
        let newCategory = Category(context: context)
        
        //2:set the attributes
        newCategory.categoryName = CategoryName
        
        return newCategory
        
        //3: after call context.save();
    }
    
    //delete
    class func Delete(CategoryName: String,context: NSManagedObjectContext) {
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "categoryName = %@", argumentArray: [CategoryName])
        let object = try! context.fetch(fetchRequest)
        context.delete(object[0])
        do {
            try context.save()
        } catch {
            print(error)
            fatalError("fail to delete.")
        }
    }
}
