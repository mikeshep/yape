//
//  Category.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let classifications: [Classification]
    let categoryDescription, device, h1Title, htmltitle: String
    let icon, image, imagepath, key: String
    let language, link: String
    let path: String
    let quantityclassifications, quantityrecipes: Int
    let shorttitle: String

    enum CodingKeys: String, CodingKey {
        case classifications
        case categoryDescription = "description"
        case device
        case h1Title = "h1title"
        case htmltitle, icon, image, imagepath, key, language, link, path, quantityclassifications, quantityrecipes, shorttitle
    }
}
