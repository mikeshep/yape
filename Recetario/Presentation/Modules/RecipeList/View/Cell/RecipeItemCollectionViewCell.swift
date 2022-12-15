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
    @IBOutlet weak var coverImageView: UIImageView! {
        didSet {
            coverImageView.layer.cornerRadius = 10
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
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
        var cdn: String
        switch k {
        case .integer(let int):
            cdn = "https://cdn7.kiwilimon.com/recetaimagen/\(int)/300x400/\(image ?? "").jpg"
        case .string(let string):
            cdn = "https://cdn7.kiwilimon.com/recetaimagen/\(string)/300x400/\(image ?? "").jpg"
        }
        return URL(string: cdn)
    }
}
