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
        guard let favoriteRecipes = try? managedObjectContext.fetch(request) else { return [] }
        return favoriteRecipes
    }

    // MARK: - Initializer

    init(coreDataRecipe: CoreDataRecipe) {
        self.coreDataRecipe = coreDataRecipe
        self.managedObjectContext = coreDataRecipe.mainContext
    }

    // MARK: - Manage Task Entity

    func createFavoriteRecipe(label: String, image: String) {
        let favoriteRecipe = FavoriteRecipe(context: managedObjectContext)
        favoriteRecipe.label = label
        favoriteRecipe.image = image
        coreDataRecipe.saveContext()
    }

    func deleteAllTasks() {
        favoriteRecipes.forEach { managedObjectContext.delete($0) }
        coreDataRecipe.saveContext()
    }
}
