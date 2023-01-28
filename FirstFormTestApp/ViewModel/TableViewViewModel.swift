//
//  TableViewViewModel.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

class TableViewViewModel: TableViewViewModelProtocol {
    
    private let dataFetcherService: DataFetcherService = DataFetcherService()
    
    private var _playLists: PlayListModel?
    private var playLists: PlayListModel? { // PLAYLIST
        get {
            let sortedAlbums = self._playLists?.albums?.sorted(by: { first, second in
                guard let title = first.title, let subTitle = second.title else { return false }
                return title.localizedStandardCompare(subTitle) == .orderedAscending
            })
            
            let playList: PlayListModel = PlayListModel(albums: sortedAlbums)
            return playList
        }
        
        set {
            self._playLists = newValue
            self._filterredPlayLists = newValue
        }
    }
    
    private var _filterredPlayLists: PlayListModel?
    private var filterredPlayLists: PlayListModel? { // MutablePlayList
        get {
            let sortedAlbums = self._filterredPlayLists?.albums?.sorted(by: { first, second in
                guard let title = first.title, let subTitle = second.title else { return false }
                return title.localizedStandardCompare(subTitle) == .orderedAscending
            })
            
            let playList: PlayListModel = PlayListModel(albums: sortedAlbums)
            return playList
            
            
        }
        set {
            self._filterredPlayLists = newValue
        }
    }
    
    
    
    func filterBy(text: String) {
        if text.isEmpty {
            self.filterredPlayLists?.albums = self.playLists?.albums
        } else {
            let filteredPlaylists = self.filterredPlayLists?.albums?.filter({
                guard let title = $0.title, let subtitle = $0.subtitle else { return false }
                let searchingHash = title.lowercased() + " " + subtitle.lowercased()
                return searchingHash.contains(text.lowercased())
            })
            self.filterredPlayLists?.albums = filteredPlaylists
        }
    }
    
    func getTitleForIndex(index: Int) -> String? {
        guard let album = filterredPlayLists?.albums?[save: index] else { return nil }
        return album.title
    }
    
    func change(title: String?, at index: Int) {
        guard let selectedAlbum = filterredPlayLists?.albums?[save: index], let title = title else { return }
        var playListIndex: Int?
        if let playListsAlbomIndex = playLists?.albums?.firstIndex(where: { $0 == selectedAlbum }) {
            playListIndex = playListsAlbomIndex
        }
        var changedAlbum = selectedAlbum
        
        changedAlbum.changedTitle(text: title)
        if let playListIndex = playListIndex {
            self.playLists?.albums?[playListIndex] = changedAlbum
        }
    }
    
    func numbersOfRows() -> Int {
        return filterredPlayLists?.albums?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        guard let album = filterredPlayLists?.albums?[save: indexPath.row] else { return nil }
        return TableViewCellViewModel(album: album)
    }
    
    func fetchData(completion: @escaping (() -> Void)) {
        dataFetcherService.fetchPlayLists { [weak self] playLists in
            guard let self = self else { return }
            self.playLists = playLists
            completion()
        }
    }
}

extension Collection { // отдельно
    
    subscript(save index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
