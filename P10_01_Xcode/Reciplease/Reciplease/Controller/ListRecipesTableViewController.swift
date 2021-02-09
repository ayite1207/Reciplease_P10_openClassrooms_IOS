//
//  ListRecipesTableViewController.swift
//  Reciplease
//
//  Created by ayite on 15/01/2021.
//

import UIKit

class ListRecipesTableViewController: UITableViewController {

//    var listRecipes : Recipes?
    var detailRecipe : InfoRecipe?
    
    private var coreDataManager: CoreDataManager?
    var favoriteTabRecipe : [Recipe] = []
    var listRecipes : ListeInfoRecipes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let coreDataRecipe = appdelegate.coreDataRecipe
        coreDataManager = CoreDataManager(coreDataRecipe: coreDataRecipe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listRecipes?.listInfoRecipe.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? RecipiesTableViewCell else{
            return UITableViewCell()
        }
        cell.recipe = listRecipes?.listInfoRecipe[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = listRecipes?.listInfoRecipe[indexPath.row] else { return }
        detailRecipe = recipe
        performSegue(withIdentifier: "detailRecipe", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Hello, you have no favorites recipes"
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let recipes = coreDataManager?.favoriteRecipes
        return listRecipes?.listInfoRecipe.count == 0 ? 200 : 0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is DetailRecipeViewController
        {
            let vc = segue.destination as? DetailRecipeViewController
            vc?.detailRecipe = self.detailRecipe
        }
    }
    

}
