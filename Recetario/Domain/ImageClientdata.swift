//
//  ImageClientdata.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

// MARK: - ImageClientdata
struct ImageClientdata: Codable {
    let avatar: String
    let ckey: Int
    let firstname, lastname, path: String
}
