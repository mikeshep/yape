//
//  RecipeBuilder.swift
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
