//
//  DetailsTanksCollectionViewController.swift
//  WOT
//
//  Created by Андрей on 09.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailsTanksCollectionViewController: UICollectionViewController {

    var tank: String = ""
    
    //Tanks parameters
    var tankName: [String] = []
    var tankNation: [String] = []
    var tankIcon: [String] = []
    var isPremium: [Bool] = []
    var tankLevel: [Int] = []
    var tankType: [String] = []
    var tankShortName: [String] = []
    var tankWins: [Int] = []
    var tankBattles: [Int] = []
    var markOfMastery: [Int] = []
    var chassis_rotation_speed: [Int] = []
    
    let managerData: ManagerData = ManagerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managerData.readPropertyList()
        
        print(tank)
        
        let userDBTanksData = self.managerData.loadDBUserTanksByTankName(tankName: tank)
        
        print(userDBTanksData)
        
        for var tank in userDBTanksData[0].UserTanksInfo {
            self.tankName.append(tank.name_i18n)
            self.tankNation.append(tank.nation_i18n)
            self.tankIcon.append(tank.image_small)
            self.tankLevel.append(tank.level)
            self.tankType.append(tank.type_i18n)
            self.isPremium.append(tank.is_premium)
            self.tankShortName.append(tank.short_name_i18n)
            
            print("1: ", tank)
            print("Load duspatch tank info")
            //var tankInfo: DictTanksData = DictTanksData();
            self.managerData.queueLoadTankDetail(tank_id: String(tank.tank_id)) { respFlag, tankInfo in
                print("2: ", tankInfo)
                self.chassis_rotation_speed.append(tankInfo.chassis_rotation_speed)
            }
        }
        
        for tankStat in userDBTanksData[0].UserTanksStat {
            self.tankBattles.append(tankStat.battles)
            self.tankWins.append(tankStat.wins)
            self.markOfMastery.append(tankStat.mark_of_mastery)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //return 1
        return tankName.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        let label1: UILabel = cell.viewWithTag(1) as! UILabel
        label1.text = String(tankName[indexPath.row])
        
        let imageView: UIImageView = cell.viewWithTag(2) as! UIImageView
        
        let imgTankIcon = URL(string: tankIcon[indexPath.row])
        
        let imageData = NSData(contentsOf: imgTankIcon! as URL)
        
        if imageData != nil {
            imageView.image = UIImage(data: imageData! as Data)
        }
        
        let label2: UILabel = cell.viewWithTag(3) as! UILabel
        //label2.text = "Statistic tank"
        label2.text = String(tankNation[indexPath.row])
        
        let label3: UILabel = cell.viewWithTag(4) as! UILabel
        label3.text = String(tankLevel[indexPath.row])
        
        let label4: UILabel = cell.viewWithTag(5) as! UILabel
        if isPremium[indexPath.row]{
            label4.text = "Да"
        }
        else{
            label4.text =  "Нет"
        }
        
        let label5: UILabel = cell.viewWithTag(6) as! UILabel
        label5.text = String(tankShortName[indexPath.row])
        
        let label6: UILabel = cell.viewWithTag(7) as! UILabel
        label6.text = String(tankType[indexPath.row])
        
        let label7: UILabel = cell.viewWithTag(8) as! UILabel
        label7.text = String(tankBattles[indexPath.row])
        
        let label8: UILabel = cell.viewWithTag(9) as! UILabel
        label8.text = String(tankWins[indexPath.row])
        
        let label9: UILabel = cell.viewWithTag(10) as! UILabel
        if(markOfMastery[indexPath.row] == 0){
            label9.text = "Отсутствует"
        }
        if(markOfMastery[indexPath.row] == 1){
            label9.text = "3 степень"
        }
        if(markOfMastery[indexPath.row] == 2){
            label9.text = "2 степень"
        }
        if(markOfMastery[indexPath.row] == 3){
            label9.text = "1 степень"
        }
        if(markOfMastery[indexPath.row] == 4){
            label9.text = "Мастер"
        }
        
        //let label10: UILabel = cell.viewWithTag(11) as! UILabel
        //label10.text = String(chassis_rotation_speed[indexPath.row])
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
