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
    
    dynamic var chassis_rotation_speed: Int = 0
    dynamic var circular_vision_radius: Int = 0
    dynamic var engine_power: Int = 0
    dynamic var gun_damage_max: Int = 0
    dynamic var gun_damage_min: Int = 0
    dynamic var gun_max_ammo: Int = 0
    dynamic var gun_name: String = ""
    dynamic var gun_piercing_power_max: Int = 0
    dynamic var gun_piercing_power_min: Int = 0
    dynamic var gun_rate: Float = 0
    dynamic var limit_weight: Float = 0
    dynamic var max_health: Int = 0
    dynamic var price_credit: Int = 0
    dynamic var price_gold: Int = 0
    dynamic var radio_distance: Int = 0
    dynamic var speed_limit: Float = 0
    dynamic var turret_armor_board: Int = 0
    dynamic var turret_armor_fedd: Int = 0
    dynamic var turret_armor_forehead: Int = 0
    dynamic var turret_rotation_speed: Int = 0
    dynamic var vehicle_armor_board: Int = 0
    dynamic var vehicle_armor_fedd: Int = 0
    dynamic var vehicle_armor_forehead: Int = 0
    dynamic var weight: Float = 0
}
