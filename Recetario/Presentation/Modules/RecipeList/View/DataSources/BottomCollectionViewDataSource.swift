//
//  BottomCollectionViewDataSource.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation
import UIKit

class BottomCollectionViewDataSource: NSObject {
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

extension BottomCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].classifications.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : RecipeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        
        let item = categories[indexPath.section].classifications[indexPath.row]
        cell.configure(dataSource: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BottomTitleCollectionReusableView", for: indexPath) as! BottomTitleCollectionReusableView
        let category = categories[indexPath.section]
        view.configure(dataSource: category.shorttitle)
        return view
    }
}
