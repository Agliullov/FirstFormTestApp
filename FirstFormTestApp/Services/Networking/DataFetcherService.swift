//
//  DataFetcherService.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchPlayLists(completion: @escaping (PlayListModel?) -> Void) {
        let urlString = "http://test.iospro.ru/playlistdata.json"
        networkDataFetcher.fetchDataFromJSON(urlString: urlString, response: completion)
    }
}
