//
//  TopCollectionViewDataSource.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation
import UIKit

class TopRecipeCollectionDataSource: NSObject {
    private var collectionView: UICollectionView
    var categories: [Category] {
        didSet {
            collectionView.reloadData()
        }
    }

    init(collectionView: UICollectionView, categories: [Category]) {
        self.collectionView = collectionView
        self.categories = categories
    }
}

extension TopRecipeCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let last = categories.last else {
            return 0
        }
        return last.classifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TopRecipeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRecipeCollectionViewCell", for: indexPath) as! TopRecipeCollectionViewCell
        guard let last = categories.last else {
            return cell
        }
        let item = last.classifications[indexPath.row]
        cell.configure(dataSource: item)
        return cell
    }
}
