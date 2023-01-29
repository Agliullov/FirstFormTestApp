//
//  Helpers.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 29.01.2023.
//

import Foundation

extension Collection {
    
    subscript(save index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
