//
//  FavoriteRecipesViewController.swift
//  Reciplease
//
//  Created by ayite on 29/01/2021.
//

import UIKit

class FavoriteRecipesViewController: UIViewController {

    // MARK: - Properties

    private var coreDataManager: CoreDataManager?
    
    @IBOutlet weak var favoriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let coreDataRecipe = appdelegate.coreDataRecipe
        coreDataManager = CoreDataManager(coreDataRecipe: coreDataRecipe)
        // Do any additional setup after loading the view.
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

extension FavoriteRecipesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRecipeCell", for: indexPath) as? RecipiesTableViewCell else{
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
