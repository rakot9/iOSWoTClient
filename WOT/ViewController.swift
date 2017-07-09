//
//  ViewController.swift
//  WOT
//
//  Created by Andrew Sobolev on 03.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//
// $HOME/Library/Developer/CoreSimulator/Devices

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON


class ViewController: UITableViewController {

    let WoTUserId: Int = 3562955
    var userTanksList: [String] = ["T-34", "T-34-85", "IS-2"]
    
    let managerData: ManagerData = ManagerData()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        managerData.loadTanksDictJSON()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTanksList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = userTanksList[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! DetailsTanksCollectionViewController
                destinationVC.tank = userTanksList[indexPath.row]
            }
        }
    }
}

