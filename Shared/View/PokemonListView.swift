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
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(viewModel.pokemons) { pokemon in
                        PokemonCardView(pokemon: pokemon, viewModel: viewModel)
                    }
                    
                    /*ForEach(viewModel.pokemons) { pokemon in
                        PokemonCardView(pokemon: pokemon, viewModel: viewModel)
                    }*/
                }
            }
        }
        .navigationTitle("Pokedex")
        .onAppear {
            Task {
                await viewModel.getPokemons()
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
