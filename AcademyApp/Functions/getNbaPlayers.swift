//
//  getNbaPlayers.swift
//  AcademyApp
//
//  Created by Gabriel Gandur on 14/03/23.
//

import Foundation

struct PlayersResponse: Codable {
    var league: League
}

struct League: Codable {
    var standard: [PlayerType]
}

struct PlayerType: Codable, Hashable {
    var collegeName: String?
    var country: String?
    var dateOfBirthUTC: String?
    var firstName: String?
    var heightFeet: String?
    var heightInches: String?
    var heightMeters: String?
    var jersey: String?
    var lastAffiliation: String?
    var lastName: String?
    var nbaDebutYear: String?
    var personId: String?
    var pos: String?
    var teamId: String?
    var weightKilograms: String?
    var weightPounds: String?
    var yearsPro: String?
}

func getNbaPlayers(completion: @escaping ([PlayerType]?) -> Void) {
    let url = URL(string: "http://data.nba.net/10s/prod/v1/2022/players.json")!

    let task = URLSession.shared.dataTask(with: url) { data, _, error in

        guard let data = data else {
            print("Dados nao encontrados")
            completion(nil)
            return
        }

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(PlayersResponse.self, from: data)
            completion(response.league.standard)
        } catch {
            print("Erro ao converter JSON: \(error)")
            completion(nil)
        }
    }

    task.resume()
}
