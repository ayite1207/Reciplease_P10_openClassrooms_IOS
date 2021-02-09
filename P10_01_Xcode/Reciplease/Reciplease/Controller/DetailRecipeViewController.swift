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
    @IBOutlet weak var showRecipeButton: UIButton!
    
    // MARK: Properties
    
    var detailRecipe : InfoRecipe?
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
            titleRecipeLabel.text = recipe.title
        }
    }
    
    private func configRightButtonNavBar(){
        star = checkIfEntityExist() ? "starFill" : "star"
        let starImage = UIImage(named: star)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(addFavorite))
        
    }

    @objc private func addFavorite(){
        print("addFavorite")
        
        guard let label = detailRecipe?.title,let image = detailRecipe?.image, let ingredients = detailRecipe?.ingredients,let url = detailRecipe?.url else { return }
        print("someEntityExists ::  \(coreDataManager?.someEntityExists(tilte: label))")
        
        if !checkIfEntityExist() {
            coreDataManager?.createFavoriteRecipe(label: label, image: image, ingredients: ingredients, url: url)
            configRightButtonNavBar()
        } else {
            guard let titleRecipe = detailRecipe?.title else { return }
            coreDataManager?.deleteRecipe(title: titleRecipe)
            configRightButtonNavBar()
        }
       
    }
    
    private func checkIfEntityExist() -> Bool{
        guard let label = detailRecipe?.title, let checkIfEntityExist = coreDataManager?.someEntityExists(tilte: label)else { return false}
        return checkIfEntityExist
    }
}

extension DetailRecipeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailRecipe?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
        
        cell.textLabel?.text = detailRecipe?.ingredients[indexPath.row]
        return cell
    } 
}
