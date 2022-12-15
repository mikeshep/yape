//
//  GetFeedUseCase.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

protocol GetFeedUseCaseProtocol {
    func execute() async throws -> ShortsRecipe
}

final class GetFeedUseCase: GetFeedUseCaseProtocol {

    typealias RequestValue = Int

    typealias ResultValue = ShortsRecipe

    private let requestValue: RequestValue
    private let recipeRepository: RecipeRepository

    init(requestValue: RequestValue,
         recipeRepository: RecipeRepository) {
        self.requestValue = requestValue
        self.recipeRepository = recipeRepository
    }

    func execute() async throws -> ResultValue {
        return try await recipeRepository.fetchFeed(id: requestValue)
    }
}
