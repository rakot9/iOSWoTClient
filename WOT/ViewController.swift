//
//  ViewController.swift
//  WOT
//
//  Created by Andrew Sobolev on 03.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        // Get realm info
        let realm = try! Realm()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let url = "https://api.worldoftanks.ru/wot/account/info/?application_id=c2efd689578281e6a764d69c433c2088&account_id=3562955"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let wotData = WotData()
                wotData.userData = json["data"]["3562955"]["nickname"].stringValue
                //Записываем в базу ник игрока -> Frondibolla
                print(wotData.userData)
                try! realm.write {
                    realm.add(wotData)
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

