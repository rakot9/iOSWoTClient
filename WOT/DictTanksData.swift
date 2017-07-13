//
//  DictTanksData.swift
//  WOT
//
//  Created by Андрей on 09.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import Foundation
import RealmSwift

class DictTanksData: Object{
    dynamic var tanksData: String = ""
    dynamic var nation_i18n: String = ""
    dynamic var name: String = ""
    dynamic var level: Int = 0
    dynamic var image: String = ""
    dynamic var image_small: String = ""
    dynamic var nation: String = ""
    dynamic var is_premium: Bool = false
    dynamic var type_i18n: String = ""
    dynamic var contour_image: String = ""
    dynamic var short_name_i18n: String = ""
    dynamic var name_i18n: String = ""
    dynamic var type: String = ""
    dynamic var tank_id: Int = 1
}
