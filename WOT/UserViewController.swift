//
//  ViewController.swift
//  Соболев Андрей
//  https://github.com/rakot9/iOSWoTClient.git
//  WOT
//
//  Created by Andrew Sobolev on 03.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

protocol ViewControllerDelegate: class{
    func reloadTableView()
}

class UserViewController: UITableViewController, ViewControllerDelegate  {
    
    var usersList: [String] = []
    let managerData: ManagerData = ManagerData()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        managerData.readPropertyList()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // Read WoT nick list from Realm DB
        let usersDBData = self.managerData.loadDBUsers()
        
        for nick in usersDBData {
            self.usersList.append(nick.nickData)
        }
        
        self.tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nick_cell", for: indexPath)
        cell.textLabel?.text = usersList[indexPath.row]    
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        if segue.identifier == "nick_detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                print("User detail prepare")
                //let destinationVC = segue.destination as! DetailsTanksCollectionViewController
                //destinationVC.tank = usersList[indexPath.row]
                //let nav = segue.destination as! UINavigationController
                //let destinationVC = nav.topViewController as! ViewController //segue.destination as! ViewController
                let destinationVC = segue.destination as! ViewController
                destinationVC.delegate = self
                destinationVC.nick = usersList[indexPath.row]
            }
        }
    }
    
    @IBAction func cancelToUserViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveUserDetail(segue:UIStoryboardSegue) {
        
        if let userDetailsTableViewController = segue.source as? UserDetailsTableViewController {
            
            let newNick: String = userDetailsTableViewController.nameTextField.text!;
            
            //add the new player to the players array
            usersList.append(newNick)
            
            //update the tableView
            self.tableView.reloadData();
            
            managerData.loadUserData(nick: newNick){respFlag, account_id in
                print("Found account id: \(account_id)")
            }
        }
    }
    
    func reloadTableView()
    {
        print("reloadTableView")
        //tableView.tableView.reloadData()
    }
}

