//
//  Recipe.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

// MARK: - Recipe
struct Recipe: Codable {
    let bc: [Bc]
    let calories: Int?
    let classification: Int
    let classificationname, classificationpath: String
    let client: Int
    let clientdata: RecipeClientdata
    let cooked, cooktime: Int?
    let cooktimestr, cuisinename, recipeDescription, device: String
    let difficulty, favorites: Int
    let htmltitle, image: String
    let images: [RecipeImage]
    let ingredients: [Ingredient]
    let key: Int
    let language: String
    let level: Int
    let link: String
    let metadescription, name: String
    let nutrients: [Nutrient]
    let path: String
    let portions: Int
    let prating, presentation: String
    let published: String
    let rating: Double
    let revised, status: Int?
    let steps: [Step]
    let tecuida: Bool
    let time: Int
    let timestr, tips, titleh1: String
    let totaltime: Int
    let totaltimestr: String
    let video: Video
    let videos: [Video]
    let view: Int

    enum CodingKeys: String, CodingKey {
        case bc, calories, classification, classificationname, classificationpath, client, clientdata, cooked, cooktime, cooktimestr, cuisinename
        case recipeDescription = "description"
        case device, difficulty, favorites, htmltitle, image, images, ingredients, key, language, level, link, metadescription, name, nutrients, path, portions, prating, presentation, published, rating, revised, status, steps, tecuida, time, timestr, tips, titleh1, totaltime, totaltimestr, video, videos, view
    }
}

// MARK: - Bc
struct Bc: Codable {
    let n, p: String
}
