//
//  Media.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/5/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation


public enum MediaType: String {
    case music = "music"
    case movie = "movie"
    case tvShow = "tvShow"
}


struct Media: Codable {
    
    var artworkUrl100: String
    var artistName: String?
    var trackName: String?
    var longDescription: String?
    var previewUrl: String?
    var kind: String?
    
    func getType() -> MediaType {
        switch self.kind {
        case "song":
            return MediaType.music
        case "feature-movie":
            return MediaType.movie
        case "tv-episode":
            return MediaType.tvShow
        default:
            return MediaType.music
        }
    }
}

