//
//  DetailModel.swift
//  UserCV-iOS
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 miguelleonmarti. All rights reserved.
//

import Foundation
import RealmSwift

class DetailModel {
    let realm = try! Realm()
    
    init() {}
    
    // Get user's curriculum
    func getCurriculum(_ id: Int) -> Curriculum {
        let curriculums = realm.objects(Curriculum.self)
        return curriculums[id]
    }
}
