//
//  RecipeImage.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

// MARK: - RecipeImage
struct RecipeImage: Codable {
    let client: Int
    let clientdata: ImageClientdata
    let ikey: Int
    let image: String
}
