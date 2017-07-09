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
    var dictTanksList: [(json: JSON, id: Int)] = []
    var userTanksList: [String] = ["T-34", "T-34-85", "IS-2"]
    
    func loadTanksDictJSON(){

        let urlTanksDict = "https://api.worldoftanks.ru/wot/encyclopedia/tanks/?application_id=c2efd689578281e6a764d69c433c2088"
        
        // Do any additional setup after loading the view, typically from a nib.
        // Get realm info
        let realm = try! Realm()
        
        // #Getting dictionary tanks
        Alamofire.request(urlTanksDict, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (String: tankId, JSON: jsonTanks) in json["data"] {
                    self.dictTanksList.append((json: jsonTanks, id: Int(tankId)!))
                }
//                try! realm.write {
//                    realm.add(userTanksData)
//                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadUserTanks(){
        let urlUserTanks = "https://api.worldoftanks.ru/wot/account/tanks/?application_id=c2efd689578281e6a764d69c433c2088&account_id=\(self.WoTUserId)"
        
        // #Getting users tanks
        
        Alamofire.request(urlUserTanks, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (String: _, JSON: jsonTanks) in json["data"][String(self.WoTUserId)] {
                    self.userTanksList.append(jsonTanks["tank_id"].stringValue)
                }
                //                try! realm.write {
                //                    realm.add(userTanksData)
                //                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
