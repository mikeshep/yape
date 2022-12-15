//
//  RecipeBuilder.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

enum RecipeBuilder {
    static func build(coordinator: Coordinator, key: Int) -> UIViewController {
        let recipeRepository = RecipeService()
        var getRecipeUseCase: GetRecipeUseCaseProtocol = GetRecipeUseCase(requestValue: key,
                                                                          recipeRepository: recipeRepository)
        let output = RecipeViewModelOutput()
        let input = RecipeViewModelInput()
        let viewModel = RecipeViewModel(getRecipeUseCase: getRecipeUseCase, output: output)
        let view = RecipeViewController(nibName: "RecipeViewController", bundle: nil)
        view.viewModel = viewModel
        view.input = input
        return view
    }
}
