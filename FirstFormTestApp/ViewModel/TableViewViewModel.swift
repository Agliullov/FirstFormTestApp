//
//  TableViewViewModel.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

final class TableViewViewModel: TableViewViewModelProtocol {
    
    private let dataFetcherService: DataFetcherService = DataFetcherService()
    
    private var playList: PlayListModel?
    private var mutablePlayList: PlayListModel? {
        get {
            getAlbums(model: playList)
        }
        set {
            self.playList = newValue
            self.filterredPlayList = newValue
        }
    }
    
    private var filterredPlayList: PlayListModel?
    private var mutableFilterredPlayList: PlayListModel? {
        get {
            getAlbums(model: filterredPlayList)
        }
        set {
            self.filterredPlayList = newValue
        }
    }
    
    fileprivate func getAlbums(model: PlayListModel?) -> PlayListModel {
        let sortedAlbums = model?.albums?.sorted(by: { first, second in
            guard let title = first.title, let subTitle = second.title else { return false }
            return title.localizedStandardCompare(subTitle) == .orderedAscending
        })
        
        return PlayListModel(albums: sortedAlbums)
    }
    
    
    func filterBy(text: String) {
        if text.isEmpty {
            self.mutableFilterredPlayList?.albums = self.mutablePlayList?.albums
        } else {
            let mutableFilterredPlayList = self.mutableFilterredPlayList?.albums?.filter({
                guard let title = $0.title, let subtitle = $0.subtitle else { return false }
                let searchingHash = title.lowercased() + " " + subtitle.lowercased()
                return searchingHash.contains(text.lowercased())
            })
            self.mutableFilterredPlayList?.albums = mutableFilterredPlayList
        }
    }
    
    func getTitleForIndex(index: Int) -> String? {
        guard let album = mutableFilterredPlayList?.albums?[save: index] else { return nil }
        return album.title
    }
    
    func change(title: String?, at index: Int) {
        guard let selectedAlbum = mutableFilterredPlayList?.albums?[save: index], let title = title else { return }
        var playListIndex: Int?
        if let playListsAlbumIndex = mutablePlayList?.albums?.firstIndex(where: { $0 == selectedAlbum }) {
            playListIndex = playListsAlbumIndex
        }
        var changedAlbum = selectedAlbum
        
        changedAlbum.changedTitle(text: title)
        
        if let playListIndex = playListIndex {
            self.mutablePlayList?.albums?[playListIndex] = changedAlbum
        }
    }
    
    func numbersOfRows() -> Int {
        return mutableFilterredPlayList?.albums?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        guard let album = mutableFilterredPlayList?.albums?[save: indexPath.row] else { return nil }
        return TableViewCellViewModel(album: album)
    }
    
    func fetchData(completion: @escaping (() -> Void)) {
        dataFetcherService.fetchPlayLists { [weak self] playLists in
            guard let self = self else { return }
            self.mutablePlayList = playLists
            completion()
        }
    }
}
