//
//  RecipeListViewController.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit
import Combine

class RecipeListViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: RecipeListViewModel!
    var input: RecipeListViewModelInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        let recipeRepository = RecipeService()
        let useCase = GetCategoriesUseCase(requestValue: (), recipeRepository: recipeRepository)
        let output = RecipeListViewModelOutput()
        let viewModel = RecipeListViewModel(getClassificationsUseCase: useCase, output: output)

        self.viewModel = viewModel
        self.input = RecipeListViewModelInput()
        _ = self.viewModel.bind(input: input)

        input.viewDidLoadPublisher.send(())
    }
}
