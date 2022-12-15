//
//  Coordinator.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    func start()
    func goToRecipeCategories()
    func goToRecipeList(key: Int)
    func goToRecipe()
}
