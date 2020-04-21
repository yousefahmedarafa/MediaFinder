//
//  MoviesDB.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/20/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import SQLite

struct MoviesDB {
    
    let movieTable = Table("media")
    let id = Expression<Int>("id")
    let artworkUrl100 = Expression<String>("artworkUrl100")
    let artistName = Expression<String>("artistName")
    let trackName = Expression<String>("trackName")
    let longDescription = Expression<String>("longDescription")
    let previewUrl = Expression<String>("previewUrl")
    let kind = Expression<String>("kind")
    
    static func setupMediaDB(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("media").appendingPathExtension("sqlite3")
            let myDatabase = try Connection(fileUrl.path)
            database = myDatabase
        } catch {
            print(error)
        }
    }
    
    func createMedia(){
        let createTable = movieTable.create (ifNotExists: true){ (table) in
            table.column(id, primaryKey: true)
            table.column(artworkUrl100)
            table.column(artistName)
            table.column(trackName)
            table.column(longDescription)
            table.column(previewUrl)
            table.column(kind)
        }
        
        do {
            try database.run(createTable)
            print("Movie Table Created")
        } catch {
            print(error)
        }
    }
    
    func insertMedia(mediaArr: [Media]){
        
        for media in mediaArr {
            guard let artistName = media.artistName else { return }
            guard let trackName = media.trackName else { return }
            guard let longDescription = media.longDescription else { return }
            guard let previewUrl = media.previewUrl else { return }
            guard let kind = media.kind else { return }
            
            let insertion = movieTable.insert(self.artworkUrl100 <- media.artworkUrl100,
                                              self.artistName <- artistName,
                                              self.trackName <- trackName,
                                              self.longDescription <- longDescription,
                                              self.previewUrl <- previewUrl,
                                              self.kind <- kind)
            do {
                try database.run(insertion)
                print("Media Inserted Successfully")
            } catch {
                print(error)
            }
        }
        
    }
    
    func selectAllMedia() -> [Media] {
        var mediaArray = [Media]()
        do {
            let allMedia = try database.prepare(self.movieTable)
            for media in allMedia {
                let newMedia = Media(artworkUrl100: media[self.artworkUrl100],
                                     artistName: media[self.artistName],
                                     trackName: media[self.trackName],
                                     longDescription: media[self.longDescription],
                                     previewUrl: media[self.previewUrl],
                                     kind: media[self.kind])
                mediaArray += [newMedia]
                print("Successfully Selected Media")
            }
        } catch {
            print(error)
        }
        return mediaArray
    }
}
