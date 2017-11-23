//
//  Card.swift
//  CoreDataCard
//
//  Created by LIANG ZHAO on 2017-11-09.
//  Copyright © 2017 bcit. All rights reserved.
//

import UIKit
import CoreData
class Card: NSManagedObject {
    //create func
    class func CreateCard(KeyWord: String,CardFront: String,CardBack:String,CardCategoryNew: AnyObject, in context: NSManagedObjectContext) -> Card?
    {        
        //query to check if the db had the name already
        //if so, return nil
        let fetchRequest: NSFetchRequest<Card> = Card.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "keyword = %@", argumentArray: [KeyWord])
        let object = try! context.fetch(fetchRequest)
        if(object.count >= 1) {
            print("duplicate data")
            return nil
        }
        
        //1: to get a new object(new row in db)
        let newCard = Card(context: context)
        
        //2:set the attributes
        newCard.keyword = KeyWord
        newCard.cardfront = CardFront
        newCard.cardback = CardBack
        newCard.category = CardCategoryNew as? Category
        
        return newCard
        
        //3: after call context.save();
    }
    
    //delete
    class func Delete(KeyWord: String,context: NSManagedObjectContext) {
        
        let fetchRequest: NSFetchRequest<Card> = Card.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "keyword = %@", argumentArray: [KeyWord])
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
