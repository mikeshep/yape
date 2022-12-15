//
//  RecipeCollectionViewCell.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView! {
        didSet {
            coverImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension RecipeCollectionViewCell {
    func configure(dataSource: TopRecipeCollectionViewCellDataSource) {
        titleLabel.text = dataSource.title
        coverImageView.sd_setImage(with: dataSource.url)
    }
}
