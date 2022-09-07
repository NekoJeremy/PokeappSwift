//
//  PokemonListView.swift
//  Pokeapp (iOS)
//
//  Created by Marco Cordoba on 06-09-22.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject var viewModel : ViewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<19) { _ in
                    PokemonCardView()
                }
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
