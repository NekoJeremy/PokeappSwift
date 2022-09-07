//
//  PokemonListView.swift
//  Pokeapp (iOS)
//
//  Created by Marco Cordoba on 06-09-22.
//

import SwiftUI

struct PokemonListView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(0..<19) { _ in
                        PokemonCardView()
                    }
                }
            }
        }.navigationTitle("Pokedex")
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
