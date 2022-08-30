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
    let frontDefault: String

    enum CodingKeys : String, CodingKey {
        case urlDescription : "url"
    }

    init(from decoder: Decoder) throws {
        let description = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .urlDescription)
        print("description is here -------", description)
        self.frontDefault = try description.decode(String.self, forKey: .urlDescription)
    }
}

struct PokemonResponseDataModel : Decodable {
    let pokemons : [PokemonDataModel]
    
    enum CodingKeys : String, CodingKey {
        case results
        case urlDescription : "url"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([PokemonDataModel].self, forKey: .results)
        let description = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .urlDescription)
        print("description is here -------", description)
        print(pokemons)
        self.frontDefault = try 
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
            if let _ = error {
                print("Error en getPokemonList")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                let pokemonDataModel = try JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
                DispatchQueue.main.async {
                    self.pokemons = pokemonDataModel.pokemons
<<<<<<< HEAD:Shared/ListViewModel.swift
                    //print("species ------- "+[pokemonDataModel].species)
                }
=======
>>>>>>> parent of fbb5c8f (change viewModel to list):Shared/ViewModel.swift
                }
        }.resume()
    }
<<<<<<< HEAD:Shared/ListViewModel.swift

    /*
    func getPokemonDescription() {
        let index = offset + [pokemonDataModel].species
        let urlDescription = URL(string: "https://pokeapi.co/api/v2/pokemon-species/"+index)
    }
    */
=======
>>>>>>> parent of fbb5c8f (change viewModel to list):Shared/ViewModel.swift
}
