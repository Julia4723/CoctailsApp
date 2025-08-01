//
//  CocktailsCore+CoreDataProperties.swift
//  CoctailsApp
//
//  Created by user on 30.07.2025.
//
//

import Foundation
import CoreData


extension CocktailsCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CocktailsCore> {
        return NSFetchRequest<CocktailsCore>(entityName: "CocktailsCore")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var instruction: String?
    @NSManaged public var title: String?
    @NSManaged public var ingredients: [String]?

}

extension CocktailsCore : Identifiable {

}
