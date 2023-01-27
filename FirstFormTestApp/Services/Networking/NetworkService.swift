//
//  NetworkService.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

protocol DataFetcher {
    func fetchDataFromJSON<T: Codable>(urlString: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    
    private var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchDataFromJSON<T: Codable>(urlString: String, response: @escaping (T?) -> Void) {
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSONData(type: T.self, from: data)
            response(decoded)
        }
    }
    
    private func decodeJSONData<T: Codable>(type: T.Type, from: Data?) -> T? {
        guard let data = from else { return nil }
        let decoder = JSONDecoder()
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON: \(jsonError.localizedDescription)")
            return nil
        }
    }
}
