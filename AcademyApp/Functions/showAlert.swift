//
//  showAlert.swift
//  AcademyApp
//
//  Created by Gabriel Gandur on 16/03/23.
//

import Foundation
import SwiftUI

func showAlert(player: PlayerType, completion: (() -> Void)?) {
    if let teamId = player.teamId {
        let teamName = teamNameHelper(teamId: teamId)
        if let personId = player.personId {
            if let imageURL = URL(string: "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/\(personId).png") {
                downloadPlayerImage(from: imageURL) { imageData in
                    DispatchQueue.main.async {
                        let alert = NSAlert()
                        alert.messageText = "\(player.jersey!) | \(player.firstName!) \(player.lastName!)"
                        alert.informativeText = "País: \(player.country!)\nAltura: \(player.heightMeters!) m\nPeso: \(player.weightKilograms!) kg\nTemporadas jogadas: \(player.yearsPro!)\nTime: \(teamName)"
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
