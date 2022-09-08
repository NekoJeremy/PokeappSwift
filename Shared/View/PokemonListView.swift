//
//  PokemonListView.swift
//  Pokeapp (iOS)
//
//  Created by Marco Cordoba on 06-09-22.
//

import SwiftUI

struct PokemonListView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    @StateObject var viewModel = PokemonViewModel()
    
    
    //var pokemons : [PokemonBasicDataModel] = PokemonViewModel.pokemons
    
    var body: some View {
        NavigationView {
            //Text(viewModel.pokemons[1].name)
            /*
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    /*ForEach(pokemons) { pokemon in
                        PokemonCardView(pokemon: pokemon, viewModel: viewModel)
                    }*/
                }
            }*/
        }
        //.navigationTitle("Pokedex")
        .onAppear {
            viewModel.getPokemons()
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
