//
//  PokemonModel.swift
//  Pokeapp (iOS)
//
//  Created by Marco Cordoba on 06-09-22.
//

import Foundation

struct PokemonBasicDataModel : Decodable {
    let name : String
    let url : String
}

struct PokemonDataModel : Decodable {
    var id = UUID()
    let name: String
    let url: String
    let type: String
    let image: String
    
    enum CodingKeys : String, CodingKey {
        case name
        case url
        case type
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try! container.decode(String.self, forKey: .name)
        self.url = try! container.decode(String.self, forKey: .url)
        self.type = try! container.decode(String.self, forKey: .name)
        self.image = try! container.decode(String.self, forKey: .name)
    }
}

struct PokemonListDataModel : Decodable {
    var genericContainerPokemon : [PokemonDataModel] = []

    enum CodingKeys : String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.genericContainerPokemon = try! container.decode([PokemonDataModel].self, forKey: .results)
    }

}

struct AbilitiesDataModel : Decodable {
    var ability : [PokemonBasicDataModel] = []
}

struct MovesViewModel : Decodable {
    let move : PokemonDataModel?
    var versionGroupDetails : [VersionGroupDetailsViewModel]? = []
    
    enum CodingKeys : String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.move = try container.decode(PokemonDataModel.self, forKey: .move)
        self.versionGroupDetails = try container.decode([VersionGroupDetailsViewModel].self, forKey: .versionGroupDetails)
    }
}

struct VersionGroupDetailsViewModel : Decodable {
    let levelLearnedAt : Int?
    let moveLearnMethod : PokemonDataModel?
    let versionGroup : PokemonDataModel?
    
    enum CodingKeys : String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.levelLearnedAt = try container.decode(Int.self, forKey: .levelLearnedAt)
        self.moveLearnMethod = try container.decode(PokemonDataModel.self, forKey: .moveLearnMethod)
        self.versionGroup = try container.decode(PokemonDataModel.self, forKey: .versionGroup)
        
    }
}

//modelo del pokemon individual y su detalle
struct PokemonDescriptionDataModel : Decodable {
    let id : Int?
    var abilities : [AbilitiesDataModel]? = []
    let baseExperience : Int?
    var forms : [PokemonDataModel]? = []
    let height : Int?
    let weight : Int?
    var moves : [MovesViewModel]? = []
    let name : String?
    let order : Int?
    var species : PokemonDataModel?
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
        self.forms = try container.decode([PokemonDataModel].self, forKey: .forms)
        self.height = try container.decode(Int.self, forKey: .height)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.moves = try container.decode([MovesViewModel].self, forKey: .moves)
        self.name = try container.decode(String.self, forKey: .name)
        self.order = try container.decode(Int.self, forKey: .order)
        self.species = try container.decode(PokemonDataModel.self, forKey: .species)
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
    let type : PokemonDataModel?
}

struct GenericStat : Decodable {
    let baseStat : Int?
    let effort : Int?
    let stat : PokemonDataModel?
}


