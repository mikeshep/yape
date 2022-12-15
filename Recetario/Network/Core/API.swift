//
//  API.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

struct API {
    static var schemeURL: String { scheme + "://" + URL}
    static var scheme: String { return "https" }
    static var URL: String {
        "gr.kiwilimon.com/v6"
    }
}
