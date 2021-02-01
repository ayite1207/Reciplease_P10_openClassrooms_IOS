//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by ayite on 26/01/2021.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var ingredientRecipeLabel: UILabel!
    @IBOutlet weak var showRecipeButton: UIButton!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    // MARK: Properties
    
    var detailRecipe : Recipe?
    var star : String = "star"
    private var coreDataManager: CoreDataManager?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataRecipe = appdelegate.coreDataRecipe
        coreDataManager = CoreDataManager(coreDataRecipe: coreDataRecipe)
        
        
        displayRecipe()
        configRightButtonNavBar()
    }
    
    // MARK: Methodes
    
    private func displayRecipe(){
        if let recipe = detailRecipe {
            let stringPicture = recipe.image
            let urlPicture =  URL(string: stringPicture )
            recipeImage.load(url: urlPicture!)
            titleRecipeLabel.text = recipe.label
            ingredientRecipeLabel.text = "Ingrédients"
            recipe.ingredientLines.forEach { (ingredient) in
                ingredientsLabel.text! += "- \(ingredient)\n"
            }
        }
    }
    
    private func configRightButtonNavBar(){
        let starImage = UIImage(named: star)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(addFavorite))
        
    }

    @objc private func addFavorite(){
        print("addFavorite")
        
        guard let label = detailRecipe?.label, let image = detailRecipe?.image else { return }
        coreDataManager?.createFavoriteRecipe(label: label, image: image)
        
        star = star == "star" ? "starFill" : "star"
        configRightButtonNavBar()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
