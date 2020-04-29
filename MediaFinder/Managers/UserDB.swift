//
//  DB.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/20/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import SQLite



struct UserDB {
    
    static var database: Connection!
    static let userTable = Table("users")
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let mail = Expression<String>("mail")
    static let phone = Expression<String>("phone")
    static let address = Expression<String>("address")
    static let password = Expression<String>("password")
    static let gender = Expression<String>("gender")
    static let isLoggedIn = Expression<Bool>("isLoggedIn")
    
    static func setupDB(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let myDatabase = try Connection(fileUrl.path)
            database = myDatabase
        } catch {
            print(error)
        }
    }
   
     static func create(){
        let createTable = userTable.create (ifNotExists: true){ (table) in
                    table.column(id, primaryKey: true)
                    table.column(mail, unique: true)
                    table.column(name)
                    table.column(phone)
                    table.column(address)
                    table.column(password)
                    table.column(gender)
                    table.column(isLoggedIn)
                }

                do {
                    try database.run(createTable)
                    print("Table Created")
                } catch {
                    print(error)
                }
    }
    
    static func insertUser(user:User){
        let insertion = userTable.insert(self.mail <- user.email,
                                         self.name <- user.name,
                                         self.phone <- user.phone,
                                         self.address <- user.address,
                                         self.password <- user.password,
                                         self.gender <- user.gender!.rawValue,
                                         self.isLoggedIn <- user.isLoggedIn)
        do {
            try database.run(insertion)
            print("Inserted Successfully")
        } catch {
            print(error)
        }
    }
    
    static func updateField(fieldName :Expression<String> , newFieldValue :String){
        let userID = self.userTable.filter(self.id == id)
        let updateUserField = userID.update(fieldName <- newFieldValue)
        do {
            try database.run(updateUserField)
            print("Successfully Updated")
        } catch {
            print(error)
        }
    }
    
    static func user(isLoggedIn :Bool){
        let userMail = self.userTable.filter(self.mail == mail)
        let updateUser = userMail.update(self.isLoggedIn <- isLoggedIn)
        do {
            try database.run(updateUser)
        } catch {
            print(error)
        }
    }
    
    static func selectAllUsers()->User{
//        var allUsers = [User]()
        var newUser = User()
        do {
            let users = try database.prepare(self.userTable)
            for user in users {
                newUser.address = user[self.address]
                newUser.gender = Gender(rawValue: user[self.gender])
                newUser.isLoggedIn = user[self.isLoggedIn]
                newUser.name = user[self.name]
                newUser.email = user[self.mail]
                newUser.password = user[self.password]
                newUser.phone = user[self.phone]
//                allUsers.append(newUser)
                print("Successfully Selected")
            }
        } catch {
            print(error)
        }
        return newUser
    }
    
    static func deleteUserTable(){
        let table = self.userTable
        let deleteHistory = table.delete()
        do {
            try self.database.run(deleteHistory)
        } catch {
            print(error)
        }
    }
    
}
