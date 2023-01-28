//
//  PlayListModel.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

struct PlayListModel: Codable, Equatable {
    
    var albums: [Album]?
    
    mutating func changeAlbums(albums: [Album]?) {
        self.albums = albums
    }
}

struct Album: Codable, Equatable {
    var title: String?
    let subtitle: String?
    let image: String?
    
    mutating func changedTitle(text: String) {
        self.title = text
    }
}
