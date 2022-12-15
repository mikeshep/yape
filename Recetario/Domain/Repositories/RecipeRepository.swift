//
//  RecipeRepository.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

protocol RecipeRepository {
    func fetchCategories() async throws -> [Category]
    func fetchSuggestions(string: String) async throws -> [Suggestion]
    func fetchSearch(q: String) async throws -> ShortsRecipe
    func fetchFeed(id: Int) async throws -> ShortsRecipe
}
