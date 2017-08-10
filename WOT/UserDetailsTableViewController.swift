//
//  UserDetailsTableViewController.swift
//  WOT
//
//  Created by Андрей on 07.08.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import UIKit

class UserDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
