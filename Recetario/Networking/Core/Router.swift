//
//  Router.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation
import CryptoKit

enum Router: Equatable {
    case categories
    case search(q: String)
    case feed(id: Int)

    var url: String { scheme + "://" + host + path }
    var scheme: String { API.scheme }
    var host: String { API.URL }

    var path: String {
        switch self {
        case .categories:
            return "/recipefamilies"
        case .search:
            return "/search"
        case .feed:
            return "/feed"
        }
    }

    var parameters: [URLQueryItem]? {
        nil
    }

    var headers: [String: String] {
        return [
            "Host": "gr.kiwilimon.com",
            "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
            "Connection": "keep-alive",
            "Accept": "*/*",
            "User-Agent": "kiwilimon/1.0 CFNetwork/1399 Darwin/22.1.0",
            "Content-Length": "40",
            "Accept-Language": "es-MX,es-419;q=0.9,es;q=0.8",
            "Accept-Encoding": "gzip, deflate, br",
        ]
    }

    var body: Data? {
        switch self {
        case .categories:
            return "full=yes&human=1&language=es&device=ios&".data(using: .utf8)
        case .search(let q):
            return "v=1&q=\(q)&quantity=10&page=1&order=1&multimedia=0&&language=es&device=ios&".data(using: .utf8)
        case .feed(let id):
            return  "idioma=es&dispositivo=ios&v=1&type=recetaclasificaciontop&order=1&key=\(id)&quantity=10&page=1&language=es&device=ios&".data(using: .utf8)
        }
    }
    

    var method: String {
        switch self {
        case .categories:
            return "POST"
        case .search:
            return "POST"
        case .feed:
            return "POST"
        }
    }

}
