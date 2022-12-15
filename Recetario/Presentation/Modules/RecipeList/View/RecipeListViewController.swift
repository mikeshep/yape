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

    private var subscriptions = Set<AnyCancellable>()
    private var items: [ShortRecipe] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            let nib = UINib(nibName: "RecipeItemCollectionViewCell", bundle: .main)
            collectionView.register(nib, forCellWithReuseIdentifier: "RecipeItemCollectionViewCell")
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
            .sink { completion in
                if case let .failure(error) = completion {
                    self.show(error: error)
                }
            } receiveValue: { items in
                self.items = items
            }
            .store(in: &subscriptions)
    }
}

extension RecipeListViewController: UICollectionViewDelegate {
    
}

extension RecipeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : RecipeItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeItemCollectionViewCell", for: indexPath) as! RecipeItemCollectionViewCell
        let item = items[indexPath.row]
        cell.configure(dataSource: item)
        return cell
    }
}
