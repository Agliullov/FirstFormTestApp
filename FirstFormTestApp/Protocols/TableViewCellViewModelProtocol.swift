//
//  TableViewCellViewModelProtocol.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import Foundation

protocol TableViewCellViewModelProtocol: AnyObject {
    var title: String { get }
    var subTitle: String { get }
    var imageName: String { get }
    
    var textChanged: Box<String?> { get }
}
