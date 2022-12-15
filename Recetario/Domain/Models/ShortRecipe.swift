//
//  ShortRecipe.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

// MARK: - ShortRecipe
struct ShortRecipe: Codable {
    let credits, image: String?
    let k: K
    let m: Int?
    let mt: String
    let name, path, pr: String?
    let s: Int?
    let t: String
    let v: String?
    let vh: String?
    let vp: String?
    let score: String?
    let x: String
    let date: Date?
    let ms, payloadClass, formatid, nid: String?
    let num, placementid, preid, size: String?

    enum CodingKeys: String, CodingKey {
        case path = "pa"
        case score = "vr"
        case name = "n"
        case image = "i"
        case credits = "cn"
        case k, m, mt, pr, s, t, v, vh, vp, x, date, ms
        case payloadClass = "class"
        case formatid, nid, num, placementid, preid, size
    }
}

enum K: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(K.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for K"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
