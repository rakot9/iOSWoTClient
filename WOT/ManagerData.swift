//
//  ManagerData.swift
//  WOT
//
//  Created by Андрей on 09.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class ManagerData{
    
    let WoTUserId: Int = 3562955
    
    func loadTanksDictJSON(userTanks: [Int], userTanksStat: [(wins: Int, battles: Int, mark_of_mastery: Int, tankId: Int)], completionHandler: @escaping(Bool, [(json: JSON, id: Int)]) -> ()){

        let urlTanksDict = "https://api.worldoftanks.ru/wot/encyclopedia/tanks/?application_id=c2efd689578281e6a764d69c433c2088"
        
        // Do any additional setup after loading the view, typically from a nib.
        // Get realm info
        let realm = try! Realm()
        
        // #Getting dictionary tanks
        Alamofire.request(urlTanksDict, method: .get).validate().responseJSON { response in
            
            var dictTanksList: [(json: JSON, id: Int)] = []
            
            switch response.result {
                
            case .success(let value):
                
                let json = JSON(value)
                
                for (String: tankId, JSON: jsonTanks) in json["data"] {
                    
                    let castTankId:Int = Int(tankId)!
                    
                    if userTanks.contains(castTankId) {
                        
                        var userTanks = UserTanksData()
                        userTanks.tankName = jsonTanks["name_i18n"].stringValue
                        
                        var dictTank = DictTanksData()
                        var statTank = UserTankStat()
                        
                        dictTank.nation_i18n = jsonTanks["nation_i18n"].stringValue
                        dictTank.name = jsonTanks["name"].stringValue
                        dictTank.level = jsonTanks["level"].intValue
                        dictTank.image = jsonTanks["image"].stringValue
                        dictTank.image_small = jsonTanks["image_small"].stringValue
                        dictTank.nation = jsonTanks["nation"].stringValue
                        dictTank.is_premium = jsonTanks["is_premium"].boolValue
                        dictTank.type_i18n = jsonTanks["type_i18n"].stringValue
                        dictTank.contour_image = jsonTanks["contour_image"].stringValue
                        dictTank.short_name_i18n = jsonTanks["short_name_i18n"].stringValue
                        dictTank.name_i18n = jsonTanks["name_i18n"].stringValue
                        dictTank.type = jsonTanks["type"].stringValue
                        dictTank.tank_id = jsonTanks["tank_id"].intValue
                        
                        for uTankStat in userTanksStat {
                            if(uTankStat.tankId == Int(tankId)) {
                                statTank.battles = uTankStat.battles
                                statTank.wins = uTankStat.wins
                                statTank.mark_of_mastery = uTankStat.mark_of_mastery
                            }
                        }
                        
                        userTanks.UserTanksInfo.append(dictTank)
                        userTanks.UserTanksStat.append(statTank)
                        
                        try! realm.write {
                            realm.add(userTanks, update: true)
                        }
                    }
                    
                }
//                print(self.dictTanksList)
//                try! realm.write {
//                    realm.add(userTanks)
//                }

                completionHandler(true, dictTanksList)
                
            case .failure(let error):
                print(error)
                completionHandler(true, dictTanksList)
            }
        }
    }
    
    /**
     *  Function use calback
     **/
    func loadUserTanksCallBack(completionHandler: @escaping(Bool, [Int], [(wins: Int, battles: Int, mark_of_mastery: Int, tankId: Int)]) -> ()){
        
        // Url for get all user tanks
        let urlUserTanks = "https://api.worldoftanks.ru/wot/account/tanks/?application_id=c2efd689578281e6a764d69c433c2088&account_id=\(self.WoTUserId)"
        
        // #Getting users tanks
        Alamofire.request(urlUserTanks, method: .get).validate().responseJSON { response in
            
            var userTanksList : [Int] = []
            var userTanksStat : [(wins: Int, battles: Int, mark_of_mastery: Int, tankId: Int)] = []
            
            switch response.result {
                
            case .success(let value):
                
                let json = JSON(value)
                
                for (String: _, JSON: jsonTanks) in json["data"][String(self.WoTUserId)] {
                
                    userTanksList.append(jsonTanks["tank_id"].intValue)
                    userTanksStat.append((wins: jsonTanks["statistics"]["wins"].intValue, battles: jsonTanks["statistics"]["battles"].intValue, mark_of_mastery: jsonTanks["mark_of_mastery"].intValue, tankId: jsonTanks["tank_id"].intValue))
                }
                
                completionHandler(true, userTanksList, userTanksStat)
                
            case .failure(let error):
                print(error)
                completionHandler(false, userTanksList, userTanksStat)
            }
        }
    }
    
    func loadDBUserTanks() -> Results<UserTanksData> {
        
        let realm = try! Realm()
        
        let data = realm.objects(UserTanksData)
        
        return data
    }
    
    func loadDBUserTanksByTankName(tankName: String) -> Results<UserTanksData> {
        
        let realm = try! Realm()
        let data = realm.objects(UserTanksData.self).filter("tankName BEGINSWITH %@", tankName)
        return data
    }
}
