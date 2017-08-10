//
//  WotData.swift
//  WOT
//
//  Created by Andrew Sobolev on 04.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import Foundation
import RealmSwift

class WotData: Object{
    dynamic var nickData: String = ""
    var UsersData = List<UserData>()
    
    override static func primaryKey() -> String? {
        return "nickData"
    }
}
