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
            Form {
                ForEach(viewModel.pokemons, id: \.name) { pokemon in
                    
                    ZStack {
                        VStack {
                            Text(pokemon.name)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top, 4)
                                .padding(.leading)
                        }
                    }.background(Color.cyan).padding()
                }
            }
        }.onAppear {
            viewModel.getPokemons()
            viewModel.getPokemonDescription()
        }.onTapGesture {
            //viewModel.getPokemonDescription()
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
