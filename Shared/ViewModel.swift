//
//  ViewModel.swift
//  Pokeapp
//
//  Created by Marco Cordoba on 24-08-22.
//

import Foundation
import SwiftUI

//modelo del pokemon individual dentro de la lista
struct PokemonGenericDataModel : Decodable {
    let name: String
    let url: String
}

struct ContainerGenericDataModel : Decodable {
    let genericContainerPokemon = [PokemonGenericDataModel] = []

    enum CodingKeys : String, CodingKey {
        case results
        case ability
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.genericContainerPokemon = try container.decode([PokemonGenericDataModel].self, forKey: .results)
        self.genericContainerPokemon = try container.decode([PokemonGenericDataModel].self, forKey: .ability)
    }

}

//modelo del pokemon individual y su detalle
struct PokemonDescriptionDataModel : Decodable {
    let id : Int
    let abilities : [ContainerGenericDataModel] = []
    let baseExperience : Int
    let forms : [PokemonGenericDataModel] = []
    let height : Int
    let weight : Int
    let moves : [
        let move : PokemonGenericDataModel
        let versionGroupDetails : [
            let levelLearnedAt : Int
            let moveLearnMethod : PokemonGenericDataModel
            let versionGroup : PokemonGenericDataModel 
        ]
    ]
    let name : String
    let order : Int
    let species : PokemonGenericDataModel
    let sprites : {
        let backDefault 
        let backFemale
        let backShiny
        let backShinyFemale
        let frontDefault
        let frontFemale
        let frontShiny
        let frontShinyFemale
        let other : {
            let dream_world : sprites
            let home : sprites
            let officialArtwork : sprites
        }
    }
    let stats : [GenericStat]
    let type : [TypesDataModel]
}   

struct TypesDataModel : Decodable {
    let slot : Int
    let type : PokemonGenericDataModel
}

struct GenericStat : Decodable {
    let baseStat : Int
    let effort : Int
    let stat : PokemonGenericDataModel
}


final class ViewModel : ObservableObject {
    
    @Published var pokemons : [PokemonGenericDataModel] = []

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
                let PokemonGenericDataModel = try! JSONDecoder().decode(PokemonListDataModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.pokemons = PokemonGenericDataModel.pokemons
                    print(PokemonGenericDataModel.pokemons)
                    
                    PokemonGenericDataModel.pokemons.forEach() { poke in
                        print("pokeurl-------------------------", poke.url)
                        urlSession.dataTask(with: poke.url) { data, response, error in
                            if let _ = error {
                                print("Error al obtener el listado de pokemons")
                            }
                            
                            let httpResponse = response as! HTTPURLResponse
                            
                            if let data = data,
                               httpResponse.statusCode == 200 {
                                print("data pokemon -----",data)
                                let PokemonGenericDataModel = try! JSONDecoder().decode(PokemonListDataModel.self, from: data)
                                
                                DispatchQueue.main.async {
                                    self.pokemons = PokemonGenericDataModel.pokemons
                                    print(PokemonGenericDataModel.pokemons)
                        }
                    }
                }
            }
        }.resume()       
    }
        }
    
    func getPokemonDescription() {
        //let url = URL
    }
