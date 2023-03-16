//
//  ContentView.swift
//  AcademyApp
//
//  Created by Gabriel Gandur on 14/03/23.
//

import AppKit
import SwiftUI

struct ContentView: View {
    @State var players: [PlayerType] = []

    var body: some View {
        NavigationView {
            List(players, id: \.self) { player in
                Text("\(player.firstName!) \(player.lastName!)")
                    .onTapGesture {
                        showAlert(player: player) {
                            print("Alerta fechado")
                        }
                    }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Jogadores da NBA")
        }
        .onAppear {
            getNbaPlayers { playersJson in
                if let playersJson = playersJson {
                    players = playersJson
                } else {
                    print("Erro ao obter informações")
                }
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
