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
    let name: String?
    let url: String?
}

struct ContainerGenericDataModel : Decodable {
    var genericContainerPokemon : [PokemonGenericDataModel] = []

    enum CodingKeys : String, CodingKey {
        case results
        case ability
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.genericContainerPokemon = try! container.decode([PokemonGenericDataModel].self, forKey: .results)
        //self.genericContainerPokemon = try? container.decode([PokemonGenericDataModel].self, forKey: .ability)
    }

}

struct MovesViewModel : Decodable {
    let move : PokemonGenericDataModel?
    var versionGroupDetails : [VersionGroupDetailsViewModel]? = []
    
    enum CodingKeys : String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.move = try container.decode(PokemonGenericDataModel.self, forKey: .move)
        self.versionGroupDetails = try container.decode([VersionGroupDetailsViewModel].self, forKey: .versionGroupDetails)
    }
}

struct VersionGroupDetailsViewModel : Decodable {
    let levelLearnedAt : Int?
    let moveLearnMethod : PokemonGenericDataModel?
    let versionGroup : PokemonGenericDataModel?
    
    enum CodingKeys : String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.levelLearnedAt = try container.decode(Int.self, forKey: .levelLearnedAt)
        self.moveLearnMethod = try container.decode(PokemonGenericDataModel.self, forKey: .moveLearnMethod)
        self.versionGroup = try container.decode(PokemonGenericDataModel.self, forKey: .versionGroup)
        
    }
}

//modelo del pokemon individual y su detalle
struct PokemonDescriptionDataModel : Decodable {
    let id : Int?
    var abilities : [ContainerGenericDataModel]? = []
    let baseExperience : Int?
    var forms : [PokemonGenericDataModel]? = []
    let height : Int?
    let weight : Int?
    var moves : [MovesViewModel]? = []
    let name : String?
    let order : Int?
    var species : PokemonGenericDataModel?
    var sprites : SpritesViewModel?
    var stats : [GenericStat]?
    var type : [TypesDataModel]?
    
    enum CodingKeys : String, CodingKey {
        case id
        case abilities
        case baseExperience = "base_experience"
        case forms
        case height
        case weight
        case moves
        case name
        case order
        case species
        case sprites
        case stats
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        //self.abilities = try container.decode([ContainerGenericDataModel].self, forKey: .abilities)
        self.baseExperience = try container.decode(Int.self, forKey: .baseExperience)
        self.forms = try container.decode([PokemonGenericDataModel].self, forKey: .forms)
        self.height = try container.decode(Int.self, forKey: .height)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.moves = try container.decode([MovesViewModel].self, forKey: .moves)
        self.name = try container.decode(String.self, forKey: .name)
        self.order = try container.decode(Int.self, forKey: .order)
        self.species = try container.decode(PokemonGenericDataModel.self, forKey: .species)
        self.sprites = try container.decode(SpritesViewModel.self, forKey: .sprites)
        self.stats = try container.decode([GenericStat].self, forKey: .stats)
        self.type = try container.decode([TypesDataModel].self, forKey: .type)
    }
}
    
struct SpritesViewModel : Decodable {
    let backDefault : String?
    let backFemale : String?
    let backShiny : String?
    let backShinyFemale : String?
    let frontDefault : String?
    let frontFemale : String?
    let frontShiny : String?
    let frontShinyFemale : String?
    let other : OtherViewModel?
}
    
struct OtherViewModel : Decodable {
    let dream_world : SpritesOtherHelper?
    let home : SpritesOtherHelper?
    let officialArtwork : SpritesOtherHelper?
}
    
struct SpritesOtherHelper : Decodable {
    let backDefault : String?
    let backFemale : String?
    let backShiny : String?
    let backShinyFemale : String?
    let frontDefault : String?
    let frontFemale : String?
    let frontShiny : String?
    let frontShinyFemale : String?
}

struct TypesDataModel : Decodable {
    let slot : Int?
    let type : PokemonGenericDataModel?
}

struct GenericStat : Decodable {
    let baseStat : Int?
    let effort : Int?
    let stat : PokemonGenericDataModel?
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
                let PokemonGenericDataModel = try! JSONDecoder().decode(ContainerGenericDataModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.pokemons = PokemonGenericDataModel.genericContainerPokemon
                    print(PokemonGenericDataModel.genericContainerPokemon)
                    
                    /*
                    self.pokemons.forEach() { poke in
                        urlSession.dataTask(with: poke.url) { data, response, error in
                            if data = data {
                                print("this is the data ----------", data)
                            }
                        }
                    }
                     
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
                    }*/
                }
            }
        }.resume()       
    }
}
    
    func getPokemonDescription() {
        //let url = URL
    }
