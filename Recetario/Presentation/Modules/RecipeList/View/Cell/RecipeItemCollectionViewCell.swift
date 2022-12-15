//
//  RecipeItemCollectionViewCell.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit
import SDWebImage

protocol RecipeItemCollectionViewCellDataSource {
    var title: String { get }
    var url: URL? { get }
}

class RecipeItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(dataSource: RecipeItemCollectionViewCellDataSource) {
        titleLabel.text = dataSource.title
        coverImageView.sd_setImage(with: dataSource.url)
    }
}

extension ShortRecipe: RecipeItemCollectionViewCellDataSource {
    var title: String {
        name ?? ""
    }

    var url: URL? {
        let cdn = "https://cdn7.kiwilimon.com/\(k)/300x400/\(image ?? "").jpg"
        return URL(string: cdn)
    }
}
