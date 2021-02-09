//
//  TabBarViewController.swift
//  Reciplease
//
//  Created by ayite on 05/02/2021.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataRecipe = appdelegate.coreDataRecipe
        coreDataManager = CoreDataManager(coreDataRecipe: coreDataRecipe)
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("viewController :: \(viewController)")
        print("HEMLLO")
        if viewController == ListRecipesTableViewController() {
            let listRecepeVC = ListRecipesTableViewController()
            listRecepeVC.listRecipes = convertListeRecipe(listeRecipe : listeRecipe)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("tabBarController :: \(segue.destination)")
    }
    
    private func convertListeRecipe(listeRecipe : [FavoriteRecipe]) -> ListeInfoRecipes{
        var listInfoRecipes = ListeInfoRecipes()
            for recipe in listeRecipe {
                let image = recipe.image
                let title = recipe.label
                let subTitle = recipe.ingredients
                let ingredients = recipe.ingredients
                let url = recipe.url
                let infoRecipes = InfoRecipe(title: title, subTitle: subTitle, ingredients: ingredients, image: image, url: url)
                listInfoRecipes.listInfoRecipe.append(infoRecipes)
            }
        
        return listInfoRecipes
    }

}
