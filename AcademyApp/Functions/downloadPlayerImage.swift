//
//  downloadPlayerImage.swift
//  AcademyApp
//
//  Created by Gabriel Gandur on 16/03/23.
//

import Foundation

func downloadPlayerImage(from url: URL, completion: @escaping (Data?) -> Void) {
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
