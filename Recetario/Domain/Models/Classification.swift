//
//  Classification.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

// MARK: - Classification
struct Classification: Codable {
    let icon, image: String?
    let imagepath: String
    let key: Int
    let link, path, shorttitle: String
}

typealias Categories = [Category]
