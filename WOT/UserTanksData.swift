//
//  UserTanksData.swift
//  WOT
//
//  Created by Андрей on 09.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import Foundation
import RealmSwift

class UserTanksData: Object{
    dynamic var tankName: String = ""
    var UserTanksStat = List<UserTankStat>()
    var UserTanksInfo = List<DictTanksData>()
    
    override static func primaryKey() -> String? {
        return "tankName"
    }
}
