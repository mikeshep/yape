//
//  Builder.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation
import UIKit

struct RecipeListBuilder {
    static func build() -> RecipeListViewController {
        let recipeRepository = RecipeService()
        let useCase = GetCategoriesUseCase(requestValue: (), recipeRepository: recipeRepository)
        let output = RecipeListViewModelOutput()
        let input = RecipeListViewModelInput()
        let viewModel = RecipeListViewModel(getCategoriesUseCase: useCase, output: output)
        let view = RecipeListViewController(nibName: "RecipeListViewController", bundle: nil)
        view.viewModel = viewModel
        view.input = input
        return view
    }
}
