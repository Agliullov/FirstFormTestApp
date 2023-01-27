//
//  TableViewViewModelProtocol.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

protocol TableViewViewModelProtocol: AnyObject {
    func numbersOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol?
    
    func fetchData(completion: @escaping (PlayListModel?) -> Void)
}
