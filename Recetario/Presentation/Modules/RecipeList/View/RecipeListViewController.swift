//
//  RecipeListViewController.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit
import Combine

class RecipeListViewController: UIViewController {

    var viewModel: RecipeListViewModel!
    var input: RecipeListViewModelInput!

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var topCollectionView: UICollectionView! {
        didSet {
            topCollectionView.delegate = self
            let dataSource = TopRecipeCollectionDataSource(collectionView: topCollectionView, categories: [])
            topCollectionView.dataSource = dataSource
            topDataSource = dataSource
            let nib = UINib(nibName: "TopRecipeCollectionViewCell", bundle: .main)
            topCollectionView.register(nib, forCellWithReuseIdentifier: "TopRecipeCollectionViewCell")
        }
    }

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.layer.cornerRadius = 15
            collectionView.delegate = self
            let dataSource = BottomCollectionViewDataSource(collectionView: collectionView, categories: [])
            collectionView.dataSource = dataSource
            bottomDataSource = dataSource
            let nib = UINib(nibName: "RecipeCollectionViewCell", bundle: .main)
            collectionView.register(nib, forCellWithReuseIdentifier: "RecipeCollectionViewCell")
            let nibHeader = UINib(nibName: "BottomTitleCollectionReusableView", bundle: .main)
            collectionView.register(nibHeader, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BottomTitleCollectionReusableView")
        }
    }
    private var topDataSource: TopRecipeCollectionDataSource!
    private var bottomDataSource: BottomCollectionViewDataSource!
    private var subscriptions = Set<AnyCancellable>()
    private var categories = [Category]() {
        didSet {
            topDataSource.categories = categories
            bottomDataSource.categories = categories
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        input.viewDidLoadPublisher.send(())
    }

    func bind() {
        let output = self.viewModel.bind(input: input)
        output
            .items
            .receive(on: DispatchQueue.main)
            .sink { error in
                debugPrint(error)
            } receiveValue: { categories in
                self.categories = categories
            }
            .store(in: &subscriptions)
    }

    func show(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        present(alert, animated: true)
    }
}

extension RecipeListViewController: UICollectionViewDelegate {
    
}
