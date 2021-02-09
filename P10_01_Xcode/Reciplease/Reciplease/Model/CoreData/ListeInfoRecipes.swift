//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by ayite on 05/02/2021.
//

import Foundation

struct ListeInfoRecipes {
    var listInfoRecipe : [InfoRecipe] = []
}

struct InfoRecipe {
    var title : String
    var subTitle : String
    var ingredients : [String]
    var image : String
    var url : String
    
    init(title : String, subtitle: String, ingredients: [String], image: String, url: String) {
        self.title = title
        self.subTitle = subtitle
        self.ingredients = ingredients
        self.image = image
        self.url = url
    }
}
