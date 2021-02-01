//
//  RecipiesTableViewCell.swift
//  Reciplease
//
//  Created by ayite on 25/01/2021.
//

import UIKit

class RecipiesTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeTextLabel: UILabel!
    
    var recipe : Recipe? {
        didSet {
            recipeTitleLabel.text = recipe?.label
            recipeTextLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            if let url = URL(string: recipe!.image) {
                recipeImageView.load(url: url)
            } else {
                // en cas d echec mettre une image 
            }
        }
    }

}
