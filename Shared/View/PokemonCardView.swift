//
//  PokemonView.swift
//  Pokeapp (iOS)
//
//  Created by Marco Cordoba on 06-09-22.
//

import SwiftUI

struct PokemonCardView: View {
        
    let pokemon: PokemonDataModel
    let viewModel: PokemonViewModel
    
    init(pokemon: PokemonDataModel, viewModel: PokemonViewModel) {
        self.pokemon = pokemon
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(pokemon.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                HStack {
                    Text(pokemon.type)
                        .foregroundColor(.white)
                        .font(.subheadline).bold()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay(
                        RoundedRectangle(cornerRadius: 20)                            
                        .fill(Color.white.opacity(0.25))
                        )
                        .frame(width: 100, height: 24, alignment: .leading)
                    Image("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                        .padding([.bottom, .trailing], 4)
                }
            }
        }
        .background(Color.cyan)
        .cornerRadius(12)
    }
}
