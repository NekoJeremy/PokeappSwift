//
//  PokemonView.swift
//  Pokeapp (iOS)
//
//  Created by Marco Cordoba on 06-09-22.
//

import SwiftUI

struct PokemonCardView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("pokemon.name")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 4)
                    .padding(.leading)
                HStack {
                    Text("pokemon.type")
                        .foregroundColor(.white)
                        .font(.subheadline).bold()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay(
                        RoundedRectangle(cornerRadius: 20)                            .fill(Color.white.opacity(0.25))
                        )
                        .frame(width: 100, height: 24, alignment: .leading)
                }
            }
        }.background(Color.cyan).padding()
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCardView()
    }
}
