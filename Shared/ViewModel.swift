//
//  ViewModel.swift
//  Pokeapp
//
//  Created by Marco Cordoba on 24-08-22.
//

import Foundation
import SwiftUI

struct PokemonDataModel : Decodable {
    let name: String
    let url: String
    /*let frontDefault: String?

    enum CodingKeys : String, CodingKey {
        case urlDescription = "url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let description = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .urlDescription)
        print("description is here -------", description)
        self.frontDefault = try? description.decode(String.self, forKey: .urlDescription)
    }*/
}

struct PokemonResponseDataModel : Decodable {
    let pokemons : [PokemonDataModel]
    
    enum CodingKeys : String, CodingKey {
        case results

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([PokemonDataModel].self, forKey: .results)
        print(pokemons)
    }
}

final class ViewModel : ObservableObject {
    
    @Published var pokemons : [PokemonDataModel] = []

    var limit = 20
    var offset = 0
    
    func getPokemons() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit="+limit.codingKey.stringValue+"&amp,;offset="+offset.codingKey.stringValue)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                print("Error en getPokemons")
            }
            
            let httpResponse = response as! HTTPURLResponse
            
            if let data = data,
               httpResponse.statusCode == 200 {
                let pokemonDataModel = try! JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
                DispatchQueue.main.async {
                    self.pokemons = pokemonDataModel.pokemons
                }
            }
        }.resume()
    }
}
