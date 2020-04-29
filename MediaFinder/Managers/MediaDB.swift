//
//  MoviesDB.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/20/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import SQLite

struct MediaDB {
    
    static var db : Connection!
    static let mediaTable = Table("media")
    static let id = Expression<Int>("id")
    static let artworkUrl100 = Expression<String>("artworkUrl100")
    static let artistName = Expression<String>("artistName")
    static let trackName = Expression<String>("trackName")
    static let longDescription = Expression<String>("longDescription")
    static let previewUrl = Expression<String>("previewUrl")
    static let kind = Expression<String>("kind")
    
    static func setupMediaDB(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("media").appendingPathExtension("sqlite3")
            let myDatabase = try Connection(fileUrl.path)
//            UserDB.database = myDatabase
            db = myDatabase
        } catch {
            print(error)
        }
    }
    
    static func createMedia(){
        let createTable = mediaTable.create (ifNotExists: true){ (table) in
            table.column(id, primaryKey: true)
            table.column(artworkUrl100)
            table.column(artistName)
            table.column(trackName)
            table.column(longDescription)
            table.column(previewUrl)
            table.column(kind)
        }
        
        do {
            try db.run(createTable)
            print("Movie Table Created")
        } catch {
            print(error)
        }
    }
    
    static func insertMedia(mediaArr: [Media]){
        
        for media in mediaArr {
            
            let artistName = media.artistName ?? ""
            let trackName = media.trackName ?? ""
            let longDescription = media.longDescription ?? ""
            let previewUrl = media.previewUrl ?? ""
            let kind = media.kind ?? ""
            
            let insertion = mediaTable.insert(self.artworkUrl100 <- media.artworkUrl100,
                                              self.artistName <- artistName,
                                              self.trackName <- trackName,
                                              self.longDescription <- longDescription,
                                              self.previewUrl <- previewUrl,
                                              self.kind <- kind)
            do {
                try db.run(insertion)
                print("Media Inserted Successfully")
            } catch {
                print(error)
            }
        }
    }
    
    static func selectAllMedia() -> [Media] {
        var mediaArray = [Media]()
        do {
            let allMedia = try db.prepare(self.mediaTable)
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
    
    static func deleteMediaTable(){
        let table = self.mediaTable
        let deleteHistory = table.delete()
        do {
            try self.db.run(deleteHistory)
        } catch {
            print(error)
        }
    }
    
}
