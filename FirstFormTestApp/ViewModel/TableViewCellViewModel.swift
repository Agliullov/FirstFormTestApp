//
//  TableViewCellViewModel.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

final class TableViewCellViewModel: TableViewCellViewModelProtocol {

    private var album: Album
    
    var textChanged: Box<String?> = Box(nil)
    
    var title: String {
        return album.title
    }
    
    var subTitle: String {
        return album.subtitle
    }
    
    var imageName: String {
        album.image
    }
    
    init(album: Album) {
        self.album = album
    }
}
