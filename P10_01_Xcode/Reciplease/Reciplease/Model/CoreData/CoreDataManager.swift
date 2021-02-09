//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by ayite on 31/01/2021.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties
    
    private let coreDataRecipe: CoreDataRecipe
    private let managedObjectContext: NSManagedObjectContext
    
    var favoriteRecipes: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let favoriteRecipes = try? managedObjectContext.fetch(request) else {
           return []
        }
        return favoriteRecipes
    }
    
    
    
    // MARK: - Initializer
    
    init(coreDataRecipe: CoreDataRecipe) {
        self.coreDataRecipe = coreDataRecipe
        self.managedObjectContext = coreDataRecipe.mainContext
    }
    
    // MARK: - Manage Task Entity
    
    func createFavoriteRecipe(label: String, image: String, ingredients : [String], url: String) {
        let favoriteRecipe = FavoriteRecipe(context: managedObjectContext)
        favoriteRecipe.label = label
        favoriteRecipe.image = image
        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.url = url
        coreDataRecipe.saveContext()
    }
    
    func someEntityExists(tilte: String) -> Bool {
        var response = false
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "label = %@", tilte)
        guard let Recipes = try? managedObjectContext.fetch(request) else { return false }
        
        Recipes.forEach { (recipe) in
            if recipe.label == tilte {
                response = true
            }
        }
        return response
    }
    
    func deleteRecipe(title: String){
        
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let Recipes = try? managedObjectContext.fetch(request) else { return }
        
        Recipes.forEach { (recipe) in
            if recipe.label == title {
                managedObjectContext.delete(recipe) 
                coreDataRecipe.saveContext()
            }
        }
    }
}
