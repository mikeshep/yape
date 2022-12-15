//
//  RecipeListBuilder.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

enum RecipeListBuilder {
    static func build(coordinator: Coordinator, value: RecipeListValue) -> UIViewController {
        let recipeRepository = RecipeService()
        var searchUseCase: SearchUseCaseProtocol?
        var feedUseCase: GetFeedUseCaseProtocol?
        switch value {
        case .integer(let int):
            feedUseCase = GetFeedUseCase(requestValue: int, recipeRepository: recipeRepository)
        case .string(let string):
            searchUseCase = SearchUseCase(requestValue: string, recipeRepository: recipeRepository)
        }
        let output = RecipeListViewModelOutput()
        let input = RecipeListViewModelInput()
        let viewModel = RecipeListViewModel(searchUseCase: searchUseCase,
                                            feedUseCase: feedUseCase,
                                            output: output)
        let view = RecipeListViewController(nibName: "RecipeListViewController", bundle: nil)
        view.viewModel = viewModel
        view.input = input
        return view
    }
}

enum RecipeListValue: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(K.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RecipeListValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
