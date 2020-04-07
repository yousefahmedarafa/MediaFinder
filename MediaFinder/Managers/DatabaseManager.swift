//
//  DataManager.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/16/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
//import SQLite
//
//class DatabaseManager {
//
//    var database: Connection!
//
//    let userTable = Table("users")
//    let id = Expression<Int>("id")
//    let name = Expression<String>("name")
//    let mail = Expression<String>("mail")
//    let phone = Expression<String>("phone")
//    let address = Expression<String>("address")
//    let password = Expression<String>("password")
//    let gender = Expression<String>("gender")
//    let isLoggedIn = Expression<Bool>("isLoggedIn")
//
//    init() {
//        do {
//            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
//            let database = try Connection(fileUrl.path)
//            self.database = database
//        } catch {
//            print(error)
//        }
//        let createTable = self.userTable.create (ifNotExists: true){ (table) in
//            table.column(self.id, primaryKey: true)
//            table.column(self.mail, unique: true)
//            table.column(self.name)
//            table.column(self.phone)
//            table.column(self.address)
//            table.column(self.password)
//            table.column(self.gender)
//            table.column(self.isLoggedIn)
//        }
//
//        do {
//            try self.database.run(createTable)
//            print("Table Created")
//        } catch {
//            print(error)
//        }
//    }
//
//    func insertUser(user:User){
//        let insertion = userTable.insert(self.mail <- user.email,
//                                         self.name <- user.name,
//                                         self.phone <- user.phone,
//                                         self.address <- user.address,
//                                         self.password <- user.password,
//                                         self.gender <- user.gender!.rawValue,
//                                         self.isLoggedIn <- user.isLoggedIn)
//
//        do {
//            try self.database.run(insertion)
//            print("Inserted Successfully")
//        } catch {
//            print(error)
//        }
//    }
//
//    func retrieveUser(email : String) -> User {
//        var retrivedUser = User()
//        let userMail = self.userTable.filter(self.mail == email)
//        do {
//            let usersByMail = try database.prepare(userMail)
//            for user in usersByMail {
//                retrivedUser.email = user[self.mail]
//                retrivedUser.name = user[self.name]
//                retrivedUser.phone = user[self.phone]
//                retrivedUser.address = user[self.name]
//                retrivedUser.password = user[self.name]
//                retrivedUser.gender = Gender(rawValue: user[self.gender])
//                retrivedUser.isLoggedIn = user[self.isLoggedIn]
//            }
//            print("Retrieved Successfully")
//        } catch {
//            print(error)
//        }
//        return retrivedUser
//    }
//
//    func user(isLoggedIn :Bool){
//        let userMail = self.userTable.filter(self.mail == mail)
//        let updateUser = userMail.update(self.isLoggedIn <- isLoggedIn)
//        do {
//            try self.database.run(updateUser)
//        } catch {
//            print(error)
//        }
//    }
//
//    func selectAll(){
//        do {
//            let users = try self.database.prepare(self.userTable)
//            for user in users {
//                print("user id : \(user[self.id])\nuser mail : \(user[self.mail])\nuser password : \(user[self.password])\nuser phone : \(user[self.phone])\nuser name : \(user[self.name])")
//            }
//            print("Successfully Selected")
//        } catch {
//            print(error)
//        }
//    }
//}
