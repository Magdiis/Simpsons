//
//  EpisodeItem.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 31.05.2023.
//

import Foundation
struct EpisodeItem: Identifiable {
    var id: UUID
    var season: Int16
    var episode: Int16
    var name: String
    var plot: String
    var thumbnailUrl: String
    var isFavourite: Bool
    var userRating: Int16
}
