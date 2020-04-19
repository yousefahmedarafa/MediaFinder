//
//  SqlManager.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/18/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import SQLite

class DBManager {
    
    var database: Connection!

    let userTable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let mail = Expression<String>("mail")
    let phone = Expression<String>("phone")
    let address = Expression<String>("address")
    let password = Expression<String>("password")
    let gender = Expression<String>("gender")
    let isLoggedIn = Expression<Bool>("isLoggedIn")
    
     init(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        let createTable = self.userTable.create (ifNotExists: true){ (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.mail, unique: true)
            table.column(self.name)
            table.column(self.phone)
            table.column(self.address)
            table.column(self.password)
            table.column(self.gender)
            table.column(self.isLoggedIn)
        }

        do {
            try self.database.run(createTable)
            print("Table Created")
        } catch {
            print(error)
        }
    }
    
     func insertUser(user:User){
        let insertion = userTable.insert(self.mail <- user.email,
                                         self.name <- user.name,
                                         self.phone <- user.phone,
                                         self.address <- user.address,
                                         self.password <- user.password,
                                         self.gender <- user.gender!.rawValue,
                                         self.isLoggedIn <- user.isLoggedIn)
        do {
            try self.database.run(insertion)
            print("Inserted Successfully")
        } catch {
            print(error)
        }
    }
    
     func selectAll(){
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users {
                print("userId: \(user[self.id]), name: \(user[self.name]), email: \(user[self.mail])")
            }
        } catch {
            print(error)
        }
    }
    func selectAllUsers()->[User]{
        var allUsers = [User]()
        var newUser : User!
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users {
                newUser.address = user[self.address]
                newUser.gender = Gender(rawValue: user[self.gender])
                newUser.isLoggedIn = user[self.isLoggedIn]
                newUser.name = user[self.name]
                newUser.email = user[self.mail]
                newUser.password = user[self.password]
                newUser.phone = user[self.phone]
                allUsers.append(newUser)
                print("Successfully Selected")
                
            }
        } catch {
            print(error)
        }
        return allUsers
    }
    
}
