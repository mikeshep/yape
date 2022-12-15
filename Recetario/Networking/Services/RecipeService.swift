//
//  RecipeService.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

class RecipeService: RecipeRepository, HTTPClient {
    func fetchCategories() async throws -> [Category] {
        return try await sendRequest(endpoint: .categories, responseModel: [Category].self)
    }

    func fetchSuggestions(string: String) async throws -> [Suggestion] {
        return try await sendRequest(endpoint: .categories, responseModel: [Suggestion].self)
    }
}
