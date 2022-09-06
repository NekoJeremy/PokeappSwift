//
//  ViewModel.swift
//  Pokeapp
//
//  Created by Marco Cordoba on 24-08-22.
//

import Foundation
import SwiftUI

//modelo del pokemon individual dentro de la lista

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
                let PokemonGenericDataModel = try! JSONDecoder().decode(PokemonListDataModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.pokemons = PokemonGenericDataModel.genericContainerPokemon
                    //print(PokemonGenericDataModel.genericContainerPokemon)
                    self.pokemons.forEach() { poke in
                        
                    }
                    /*
                    self.pokemons.forEach() { poke in
                        urlSession.dataTask(with: poke.url) { data, response, error in
                            if data = data {
                                print("this is the data ----------", data)
                            }
                        }
                    }*/
                    
                    /*
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
