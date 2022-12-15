//
//  GetRecipeUseCase.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

protocol GetRecipeUseCaseProtocol {
    func execute() async throws -> Recipe
}

final class GetRecipeUseCase: GetRecipeUseCaseProtocol {

    typealias RequestValue = Int

    typealias ResultValue = Recipe

    private let requestValue: RequestValue
    private let recipeRepository: RecipeRepository

    init(requestValue: RequestValue,
         recipeRepository: RecipeRepository) {
        self.requestValue = requestValue
        self.recipeRepository = recipeRepository
    }

    func execute() async throws -> ResultValue {
        return try await recipeRepository.fetchRecipe(key: requestValue)
    }
}
