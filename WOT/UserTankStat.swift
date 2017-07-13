//
//  UserTankStat.swift
//  WOT
//
//  Created by Андрей on 12.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import Foundation
import RealmSwift

class UserTankStat: Object{
    dynamic var wins: Int = 0
    dynamic var battles: Int = 0
    dynamic var mark_of_mastery: Int = 0
}
