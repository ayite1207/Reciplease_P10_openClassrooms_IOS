//
//  ViewController.swift
//  Reciplease
//
//  Created by ayite on 03/01/2021.
//

import UIKit

class SearchRecipesViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var addIngredientsButton: UIButton!
    @IBOutlet weak var cancelListButton: UIButton!
    @IBOutlet weak var listIngredientsTableView: UITableView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    //MARK: - Properties
    
    var recipes = RecipesService()
    var listIngredients : [String] = []
    var listeRecipes : ListeInfoRecipes?
    private var coreDataManager: CoreDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - Actions
    
    @IBAction func addIngrédients(_ sender: Any) {
        guard let ingredient = ingredientsTextField.text  else { return }
        listIngredients.append(ingredient)
        ingredientsTextField.text = ""
        listIngredientsTableView.reloadData()
    }
    
    @IBAction func cancelIngrédients(_ sender: Any) {
        listIngredients.removeAll()
        listIngredientsTableView.reloadData()
        
    }
    
    @IBAction func searchRecipes(_ sender: Any) {
        if listIngredients.count > 0 {
            recipes.ingredients = listIngredients.joined(separator: ",")
            recipeRquest()
        } else {
            showAlert(with: "You have no ingrédients !!!")
        }
    }
    
    //MARK: - Methodes
    
    private func recipeRquest(){
        recipes.getRecipes { [unowned self] result in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    listeRecipes = prepareListeInfoRecipes(recipes : recipes)
//                    self.listeRecipes = recipes
                    performSegue(withIdentifier: "displayRecipies", sender: nil)
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
    
    private func prepareListeInfoRecipes(recipes : Recipes?) -> ListeInfoRecipes {
        var listInfoRecipes = ListeInfoRecipes()
        if let recipesListe = recipes {
            for recipe in recipesListe.hits {
                let image = recipe.recipe.image
                let title = recipe.recipe.label
                let subTitle = recipe.recipe.image
                let ingredients = recipe.recipe.ingredientLines
                let url = recipe.recipe.url
                let infoRecipe = InfoRecipe(title: title, subtitle: subTitle, ingredients: ingredients, image: image, url: url)
                listInfoRecipes.listInfoRecipe.append(infoRecipe)
            }
        }
        return listInfoRecipes
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ListRecipesTableViewController
        {
            let vc = segue.destination as? ListRecipesTableViewController
            vc?.listRecipes = self.listeRecipes
        }
    }
}

// MARK:- Extension TableView

extension SearchRecipesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell")
        
        cell?.textLabel?.text = " - \(listIngredients[indexPath.row])"
        return cell!
    }
    
}
