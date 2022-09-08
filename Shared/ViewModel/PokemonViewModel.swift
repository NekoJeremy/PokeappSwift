//
//  File.swift
//  Pokeapp (iOS)
//
//  Created by Marco Cordoba on 07-09-22.
//

import Foundation

final class PokemonViewModel : ObservableObject {
    
    @Published var pokemons = [PokemonDataModel]()

    let limit = 20
    let offset = 0
    
    func getPokemons() async {
        
        let urlSession = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&amp,;offset=\(offset)")!
        
        urlSession.dataTask(with: url) { data, response, error in
            if let _ = error {
                print("Error al obtener el listado de pokemons")
            }
            
            let httpResponse = response as! HTTPURLResponse
            
            if let data = data,
               httpResponse.statusCode == 200 {
                let PokemonGenericDataModel = try! JSONDecoder().decode(PokemonListDataModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.pokemons = PokemonGenericDataModel.genericContainerPokemon
                    print("self.pokemons -------- ", self.pokemons)
                    /*print(PokemonGenericDataModel.genericContainerPokemon)
                    self.pokemons.forEach() { poke in
                        print("pokeUrl ----------",poke)
                    }*/
                }
            }
        }.resume()
    }
    
    func getPokemonDescription() {
        self.pokemons.forEach() { poke in
            let urlDescrip = URL(string: poke.url)
            URLSession.shared.dataTask(with: urlDescrip!) { data, resume, error in
                if data == data {
                    print("aqui esta la data -----", data!)
                }
                
            }
        }
    }
}

