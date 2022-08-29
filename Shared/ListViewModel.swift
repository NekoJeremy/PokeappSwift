//
//  ListViewModel.swift
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

final class ListViewModel : ObservableObject {
    
    @Published var pokemons : [PokemonDataModel] = []

    var limit = 20
    var offset = 0
    let urlSession = URLSession.shared

    func getPokemonList() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit="+limit.codingKey.stringValue+"&amp,;offset="+offset.codingKey.stringValue)!
        urlSession.dataTask(with: url) { data, response, error in
            if let _ = error {
                print("Error en getPokemonList")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                let pokemonDataModel = try JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
                DispatchQueue.main.async {
                    self.pokemons = pokemonDataModel.pokemons
                    //print("species ------- "+[pokemonDataModel].species)
                }
                }
        }.resume()
    }

    /*
    func getPokemonDescription() {
        let index = offset + [pokemonDataModel].species
        let urlDescription = URL(string: "https://pokeapi.co/api/v2/pokemon-species/"+index)
    }
    */
}
