//
//  RecipesService.swift
//  Reciplease
//
//  Created by ayite on 14/01/2021.
//

import Foundation
import Alamofire

final class RecipesService {
    // MARK: - Properties
    
    var ingredients = ""
    
    // MARK: - Methodes
    
    func getRecipes(callback: @escaping (Result<Recipes, NetworkError>) -> Void) {
        print("ingredients :: \(ingredients)")
        
        guard let url = URL(string: "https://api.edamam.com/search") else { return }
        let parameters = [("app_id", Key.id),("app_key",Key.key),("q",ingredients)]
        let urlRequest = encode(baseUrl: url, with: parameters)
        
        AF.request(urlRequest).responseJSON { (data) in
          
            guard let response = data.response, response.statusCode == 200 else {
                callback(.failure(.noResponse))
                return
            }
            
            guard let dataRecipes = data.data else {
                callback(.failure(.undecodableData))
                return }
            
            guard let recipes = try? JSONDecoder().decode(Recipes.self, from: dataRecipes) else {
                callback(.failure(.undecodableData))
                return
            }
            print("nombre de recettes :: \(String(describing: recipes.hits.count) )")
            callback(.success(recipes))
           
        }
    }
    
    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        
        urlComponents.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
