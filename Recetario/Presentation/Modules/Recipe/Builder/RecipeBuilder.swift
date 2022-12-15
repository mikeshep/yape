//
//  RecipeBuilder.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

enum RecipeBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let recipeRepository = RecipeService()
        var searchUseCase: SearchUseCaseProtocol?
        var feedUseCase: GetFeedUseCaseProtocol?
        let output = RecipeViewModelOutput()
        let input = RecipeViewModelInput()
        let viewModel = RecipeViewModel(searchUseCase: searchUseCase, output: output)
        let view = RecipeViewController(nibName: "RecipeViewController", bundle: nil)
        //view.viewModel = viewModel
        //view.input = input
        return view
    }
}
