//
//  Video.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

// MARK: - Video
struct Video: Codable {
    let videoDescription: String
    let duration: Int
    let name, player, thumb, videoid: String
    let vkey: Int

    enum CodingKeys: String, CodingKey {
        case videoDescription = "description"
        case duration, name, player, thumb, videoid, vkey
    }
}
