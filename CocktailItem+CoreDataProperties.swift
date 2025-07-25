//
//  CocktailItem+CoreDataProperties.swift
//  CoctailsApp
//
//  Created by user on 24.07.2025.
//
//

import Foundation
import CoreData


extension CocktailItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CocktailItem> {
        return NSFetchRequest<CocktailItem>(entityName: "CocktailItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var instruction: String?
    @NSManaged var imageData: Data?

}

extension CocktailItem : Identifiable {

}
