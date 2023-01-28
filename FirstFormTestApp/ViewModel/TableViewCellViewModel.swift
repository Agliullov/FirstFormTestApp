//
//  TableViewCellViewModel.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

struct TableViewCellViewModel: TableViewCellViewModelProtocol {

    private var album: Album
    
    var title: String? {
        return album.title
    }
    
    var subTitle: String? {
        return album.subtitle
    }
    
    var imageURL: URL? {
        if let imageURLString = album.image {
            return URL(string: imageURLString)
        }
        return nil 
    }
    
    init(album: Album) {
        self.album = album
    }
}
