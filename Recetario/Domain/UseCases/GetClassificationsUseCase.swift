//
//  GetClassificationsUseCase.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

protocol GetCategoriesUseCaseProtocol {
    func execute() async throws -> [Category]
}

final class GetCategoriesUseCase: GetCategoriesUseCaseProtocol {

    typealias RequestValue = Void

    typealias ResultValue = [Category]

    private let requestValue: RequestValue
    private let recipeRepository: RecipeRepository

    init(requestValue: RequestValue,
         recipeRepository: RecipeRepository) {
        self.requestValue = requestValue
        self.recipeRepository = recipeRepository
    }

    func execute() async throws -> ResultValue {
        return try await recipeRepository.fetchCategories()
    }
}
