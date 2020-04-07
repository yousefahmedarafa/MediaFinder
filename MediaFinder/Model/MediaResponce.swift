//
//  MediaResponce.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/5/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation


struct MediaResponce: Decodable {
    var resultCount: Int
    var results: [Media]
}

