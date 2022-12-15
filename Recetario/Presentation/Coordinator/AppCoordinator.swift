//
//  AppCoordinator.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToRecipeCategories()
    }

    func goToRecipeCategories() {
        let viewController = RecipeCategoriesBuilder.build(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToRecipeList(key: Int) {
        let viewController = RecipeListBuilder.build(coordinator: self, value: .integer(key))
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToRecipe(key: Int) {
        let viewController = RecipeBuilder.build(coordinator: self, key: key)
        navigationController.pushViewController(viewController, animated: true)
    }
}
