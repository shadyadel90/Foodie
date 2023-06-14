//
//  Restaurant.swift
//  The Foodie
//
//  Created by Shady Adel on 07/06/2023.
//

import CoreData
public class Restaurant: NSManagedObject
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant > {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
        
    }
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var location: String
    @NSManaged public var phone: String
    @NSManaged public var summary: String
    @NSManaged public var image: Data
    @NSManaged public var rating: String?
    @NSManaged public var isFavorite: Bool
    
}
