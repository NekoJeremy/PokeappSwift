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

struct PokemonListDataModel : Decodable {
    let pokemons : [PokemonDataModel]
    
    enum CodingKeys : String, CodingKey {
        case results

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([PokemonDataModel].self, forKey: .results)
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
                print("Error al obtener el listado de pokemons")
            }
            
            let httpResponse = response as! HTTPURLResponse
            
            if let data = data,
               httpResponse.statusCode == 200 {
                let pokemonDataModel = try! JSONDecoder().decode(PokemonListDataModel.self, from: data)
                //let pokemonlist = try!
                
                DispatchQueue.main.async {
                    self.pokemons = pokemonDataModel.pokemons
                    print(pokemonDataModel.pokemons)
                    
                    pokemonDataModel.pokemons.forEach() { poke in
                        print("pokeurl-------------------------", poke.url)
                        urlSession.dataTask(with: poke.url) { data, response, error in
                            if let _ = error {
                                print("Error al obtener el listado de pokemons")
                            }
                            
                            let httpResponse = response as! HTTPURLResponse
                            
                            if let data = data,
                               httpResponse.statusCode == 200 {
                                print("data pokemon -----",data)
                                /*let pokemonDataModel = try! JSONDecoder().decode(PokemonListDataModel.self, from: data)
                                
                                DispatchQueue.main.async {
                                    self.pokemons = pokemonDataModel.pokemons
                                    print(pokemonDataModel.pokemons)*/
                        }
                    }
                }
                /*ForEach(pokemonDataModel.pokemons, id: \.name) { pokemon in
                    
                urlSession.dataTask(with: PokemonDataModel.init(name: pokemonDataModel.pokemons[1].name, url: pokemonDataModel.pokemons[1].url)) { data, response, error in
                        if let data = data {
                            let pokemonDescription = try! JSONDecoder().decode(PokemonDataModel.self, from: data)
                            print("pokedescription-------------",pokemonDescription)
                        }
                    }
                */}
            }.resume()
            
    }
        }
    
    func getPokemonDescription() {
        //let url = URL
    }
