//
//  TopRecipeCollectionViewCell.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit
import SDWebImage

protocol TopRecipeCollectionViewCellDataSource {
    var title: String { get }
    var url: URL? { get }
}

class TopRecipeCollectionViewCell: UICollectionViewCell {

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

extension TopRecipeCollectionViewCell {
    func configure(dataSource: TopRecipeCollectionViewCellDataSource) {
        titleLabel.text = dataSource.title
        coverImageView.sd_setImage(with: dataSource.url)
    }
}

extension Classification: TopRecipeCollectionViewCellDataSource {
    var title: String {
        shorttitle
    }

    var url: URL? {
        let cdn = "https://cdn7.kiwilimon.com/\(imagepath)/108x108/\(icon ?? "").jpg"
        return URL(string: cdn)
    }
}
