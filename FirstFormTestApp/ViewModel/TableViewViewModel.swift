//
//  TableViewViewModel.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

class TableViewViewModel: TableViewViewModelProtocol {
    
    private let dataFetcherService: DataFetcherService = DataFetcherService()
        
    private var playLists: PlayListModel?
    
    func numbersOfRows() -> Int {
        return playLists?.albums.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        guard let album = playLists?.albums[indexPath.row] else { return TableViewCellViewModel(album: Album(title: "", subtitle: "", image: ""))}
        return TableViewCellViewModel(album: album)
    }
        
    func fetchData(completion: @escaping (PlayListModel?) -> Void) {
        dataFetcherService.fetchPlayLists { [weak self] playLists in
            self?.playLists = playLists
            completion(playLists)
        }
    }
}
