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

    func showAlert(player: PlayerType, completion: (() -> Void)?) {
        if let personId = player.personId {
            if let imageURL = URL(string: "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/\(personId).png") {
                downloadImage(from: imageURL) { imageData in
                    DispatchQueue.main.async {
                        let alert = NSAlert()
                        alert.messageText = "Informações do jogador"
                        alert.informativeText = "\(player.firstName!) \(player.lastName!)"
                        alert.addButton(withTitle: "OK")

                        if let imageData = imageData, let image = NSImage(data: imageData) {
                            alert.icon = image
                        }

                        alert.runModal()
                        completion?()
                    }
                }
            }
        }
    }
}

func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
    let session = URLSession.shared
    let task = session.dataTask(with: url) { data, _, _ in
        guard let image = data else {
            completion(nil)
            return
        }
        completion(image)
    }
    task.resume()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
