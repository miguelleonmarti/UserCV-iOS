//
//  MasterModel.swift
//  UserCV-iOS
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 miguelleonmarti. All rights reserved.
//

import Foundation
import RealmSwift

class MasterModel {
    let realm = try! Realm()
    
    init() {}
    
    // Get users count
    func getUsersCount() -> Int {
        let users = realm.objects(User.self)
        return users.count
    }
    
    // Get user's rating
    func getRating(_ id: Int) -> Int {
        let users = realm.objects(User.self)
        return users[id].rating
    }
    
    // Get user
    func getUser(_ id: Int) -> User {
        let users = realm.objects(User.self)
        return users[id]
    }
    
    // Get user's name and surname
    func getNameAndSurname(_ id: Int) -> String {
        let users = realm.objects(User.self)
        return "\(users[id].name) \(users[id].surname)"
    }
    
    // Get user's dni
    func getDNI(_ id: Int) -> String {
        let users = realm.objects(User.self)
        return users[id].dni
    }
    
    // Get user's job
    func getJob(_ id: Int) -> String {
        let users = realm.objects(User.self)
        return users[id].job
    }
    
    // Get user's age
    func getAge(_ id: Int) -> Int {
        let users = realm.objects(User.self)
        return users[id].age
    }
    
    // Delete user and its curriculum
    func deleteUser(_ id: Int) {
        let users = realm.objects(User.self)
        
        let userToDelete = users[id]
        
        try! realm.write {
            realm.delete(userToDelete)
        }
    }
}
