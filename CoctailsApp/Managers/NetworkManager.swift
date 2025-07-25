//
//  NetworkManager.swift
//  CoctailsApp
//
//  Created by user on 27.06.2025.
//

import UIKit
import Alamofire
import Foundation

enum Link: String {
    //case main = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
    case main = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
    case search = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
}

protocol INetworkManager: AnyObject {
    func fetchAF(completion: @escaping (Result<[Cocktail], AFError>) -> Void)
}

final class NetworkManager: INetworkManager {
    
    static let shared = NetworkManager()
    var name = ""
    
    private init() { }
    
    func fetchAF(completion: @escaping (Result<[Cocktail], AFError>) -> Void) {
        let url = Link.main
        
        guard let url = URL(string: url.rawValue) else {
            completion(.failure(AFError.invalidURL(url: url as! URLConvertible)))
            return
        }
        
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        
        AF.request(request)
            .validate()
            .responseDecodable(of: CocktailsResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let cocktailsResponse):
                    print("Success: \(cocktailsResponse)")
                    let cocktails = cocktailsResponse.drinks ?? []
                    completion(.success(cocktails))
                case .failure(let error):
                    print("Error \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchSearch(completion: @escaping (Result<[Cocktail], AFError>) -> Void) {
        let URLString = Link.search.rawValue + name
        
        guard let url = URL(string: URLString) else {
            completion(.failure(AFError.invalidURL(url: URLString)))
            return
        }
        
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        
        AF.request(request)
            .validate()
            .responseDecodable(of: CocktailsResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let cocktailsResponse):
                    print("Success: \(cocktailsResponse)")
                    let cocktails = cocktailsResponse.drinks ?? []
                    completion(.success(cocktails))
                case .failure(let error):
                    print("Error \(error)")
                    completion(.failure(error))
                }
            }
    }
}
