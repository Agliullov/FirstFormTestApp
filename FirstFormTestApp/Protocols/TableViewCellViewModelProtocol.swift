//
//  TableViewCellViewModelProtocol.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

protocol TableViewCellViewModelProtocol {
    var title: String? { get }
    var subTitle: String? { get }
    var imageURL: URL? { get }
}
