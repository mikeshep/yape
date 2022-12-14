//
//  Nutrient.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

// MARK: - Nutrient
struct Nutrient: Codable {
    let daily: Int?
    let metric, name: String?
    let nkey: String
    let order: Int
    let percent: Double?
    let quantity100: Quantity100
}
