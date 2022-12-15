//
//  RecipeListViewController.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

struct ShortRecipe {
    
}

class RecipeListViewController: UIViewController {
    
    private var items: [ShortRecipe] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            let nib = UINib(nibName: "RecipeItemCollectionViewCell", bundle: .main)
            collectionView.register(nib, forCellWithReuseIdentifier: "RecipeItemCollectionViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        //let item = items[indexPath.row]
        //cell.configure(dataSource: item)
        return cell
    }
}
