//
//  RecipeCategoriesViewController.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit
import Combine

class RecipeCategoriesViewController: UIViewController {

    var viewModel: RecipeCategoriesViewModel!
    var input: RecipeCategoriesViewModelInput!
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect.zero)
        searchBar.delegate = self
        return searchBar
    }()
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
        searchBar.placeholder = "Buscar Recetas..."
        navigationItem.titleView = searchBar
        bind()
        input.viewDidLoadPublisher.send(())
    }

    func bind() {
        let output = self.viewModel.bind(input: input)
        output
            .items
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.show(error: error)
                }
            } receiveValue: { categories in
                self.categories = categories
            }
            .store(in: &subscriptions)
    }
}

extension RecipeCategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case topCollectionView:
            let value = (categories.count - 1, indexPath.row)
            input.didSelectItemPublisher.send(value)
        case self.collectionView:
            let value = (indexPath.section, indexPath.row)
            input.didSelectItemPublisher.send(value)
        default:
            show(error: RecipeServiceError.unknown)
        }
    }
}

extension RecipeCategoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension UIViewController {
    func show(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
