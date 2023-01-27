//
//  PlayListModel.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

struct PlayListModel: Codable {
    let albums: [Album]
}

struct Album: Codable {
    let title: String
    let subtitle: String
    let image: String
}
