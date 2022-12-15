//
//  BottomTitleCollectionReusableView.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

class BottomTitleCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var sectionHeaderlabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension BottomTitleCollectionReusableView {
    func configure(dataSource: String) {
        sectionHeaderlabel.text = dataSource
    }
}
