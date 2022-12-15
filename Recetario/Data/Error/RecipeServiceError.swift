//
//  RecipeServiceError.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation


enum RecipeServiceError: Error {
    case failLoadJSON
    case decode
    case invalidURL
    case noResponse
    case unauthorised
    case offline
    case unknown
}
