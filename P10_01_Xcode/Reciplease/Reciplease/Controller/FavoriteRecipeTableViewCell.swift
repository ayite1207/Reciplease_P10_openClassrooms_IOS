//
//  FavoriteRecipeTableViewCell.swift
//  Reciplease
//
//  Created by ayite on 29/01/2021.
//

import UIKit

class FavoriteRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteRecipeImage: UIImageView!
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    @IBOutlet weak var favoriteTextLabel: UILabel!
    
    var favoriteTabRecipe : [Recipe] = []
    
//    var recipe : Recipe? {
//        didSet {
//            favoriteTitleLabel.text = recipe?.label
//            favoriteTextLabel.text = recipe?.ingredientLines.joined(separator: ", ")
//            if let url = URL(string: recipe!.image) {
//                favoriteRecipeImage.load(url: url)
//            } else {
//                // en cas d echec mettre une image
//            }
//        }
//    }

}
