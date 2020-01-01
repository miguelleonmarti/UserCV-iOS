//
//  User.swift
//  UserCV-iOS
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 miguelleonmarti. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var dni: String = ""
    @objc dynamic var job: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var cvDescription: String = ""
    
    override static func primaryKey() -> String? {
      return "id"
    }
}
