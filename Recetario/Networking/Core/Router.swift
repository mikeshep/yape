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

    var url: String { scheme + "://" + host + path }
    var scheme: String { API.scheme }
    var host: String { API.URL }

    var path: String {
        switch self {
        case .categories:
            return "/recipefamilies"

        }
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .categories:
            return nil
        }
    }

    var headers: [String: String] {
        switch self {
        case .categories:
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
    }

    var body: Data? {
        return "full=yes&human=1&language=es&device=ios&".data(using: .utf8)
    }
    

    var method: String {
        switch self {
        case .categories:
            return "POST"
        }
    }

}
