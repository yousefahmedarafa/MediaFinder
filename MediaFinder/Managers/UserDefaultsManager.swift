//
//  Defaults.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/12/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation

struct UserDefaultsManager {
    
    static let userDefault = UserDefaults.standard
    static let user = User()
    
    private static let sharedInstance = UserDefaultsManager()
    
    static func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }

    func saveDataFor(user: User){
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(user) else {return}
        UserDefaultsManager.userDefault.set(encoded, forKey: UserDefaultsKeys.userModel)
    }
    
    func getSavedData()-> User {
        let decoder = JSONDecoder()
        guard let savedUser = UserDefaultsManager.userDefault.object(forKey: UserDefaultsKeys.userModel) as? Data else {return UserDefaultsManager.user}
        guard let storedData = try? decoder.decode(User.self, from: savedUser) else {return UserDefaultsManager.user}
        print(storedData.email!)
        return storedData
    }
    
    func clearUserSavedData(){
        UserDefaultsManager.userDefault.removeObject(forKey: UserDefaultsKeys.userModel)
    }
}
