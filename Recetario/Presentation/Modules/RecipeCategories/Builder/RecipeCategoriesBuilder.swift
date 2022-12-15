//
//  Builder.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation
import UIKit

enum RecipeCategoriesBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let recipeRepository = RecipeService()
        let useCase = GetCategoriesUseCase(requestValue: (), recipeRepository: recipeRepository)
        let output = RecipeCategoriesViewModelOutput()
        let input = RecipeCategoriesViewModelInput()
        let viewModel = RecipeCategoriesViewModel(getCategoriesUseCase: useCase, output: output, coordinator: coordinator)
        let view = RecipeCategoriesViewController(nibName: "RecipeCategoriesViewController", bundle: nil)
        view.viewModel = viewModel
        view.input = input
        return view
    }
}
