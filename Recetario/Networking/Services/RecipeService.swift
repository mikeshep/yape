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

    func fetchSearch(q: String) async throws -> ShortsRecipe {
        return try await sendRequest(endpoint: .search(q: q), responseModel: ShortsRecipe.self)
    }

    func fetchFeed(id: Int) async throws -> ShortsRecipe {
        return try await sendRequest(endpoint: .feed(id: id), responseModel: ShortsRecipe.self)
    }
}
