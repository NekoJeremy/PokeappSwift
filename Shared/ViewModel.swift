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
        let urlSession = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit="+limit.codingKey.stringValue+"&amp,;offset="+offset.codingKey.stringValue)!
        urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                let pokemonDataModel = try! JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
                DispatchQueue.main.async {
                    self.pokemons = pokemonDataModel.pokemons
                }
            }
        }.resume()
    }
}




/*struct PokemonDataModel : Decodable {
    let pokemons : [PokemonModel]
    
    let CodingKeys = String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKey.self)
        self.pokemons = try container.decode([PokemonModel].self, forKey: results)
    }
}

final class ViewModel {
    
    func getPokemonList() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&amp;offset=0")
        
        URLSession.shared.dataTask(with: url!) {
            /*if let _ = error {
                print("Error en getPokemonList")
            }*/
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                let pokemonModel = try JSONDecoder().decode(PokemonDataModel.self, from: data)
                print("pokemons", pokemonModel)
                }
                
        }.resume()
            
    }
}*/
