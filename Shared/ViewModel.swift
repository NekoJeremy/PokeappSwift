//
//  ViewModel.swift
//  Pokeapp
//
//  Created by Marco Cordoba on 24-08-22.
//

import Foundation
import SwiftUI

struct PokemonDataModel : Decodable {
    let next: String
    let previous: String
    let name: String
    let url: String
}

struct PokemonResponseDataModel : Decodable {
    let pokemons : [PokemonDataModel]
}

final class ViewModel {
    func executeAPI() {
        let urlSession = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&amp;offset=0")!
        
        urlSession.dataTask(with: url) { data, response, error in
            print("data --> ", data)
            print("response -> ", response)
            print("error -> ", error)
            if let data = data {
                let jsonPokemon = try? JSONSerialization.jsonObject(with: data)
                print(jsonPokemon)
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
