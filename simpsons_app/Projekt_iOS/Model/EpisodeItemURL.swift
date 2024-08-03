//
//  EpisodeItemURL.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 31.05.2023.
//

import Foundation
struct EpisodeItemURL:  Hashable, Codable {
    let season: Int
    let episode: Int
    let name: String
    let description: String
    let thumbnailUrl: String
}
