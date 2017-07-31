//
//  ManagerFile.swift
//  WOT
//
//  Created by Андрей on 24.07.17.
//  Copyright © 2017 Andrew Sobolev. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import NVHTarGzip

class ManagerFile {
    
    var fileContent: String = ""
    let homeDir: String
    let filePath: String
    
    init(fPath: String, fName: String){
        self.homeDir = NSHomeDirectory()
        self.filePath = self.homeDir + "/" + fPath + "/" + fName
        print(self.homeDir)
    }
    
    func create() {
        
        let content: String = ""
        
        do {
            try content.write(toFile: self.filePath, atomically: true, encoding: String.Encoding.utf8)
            
            print("File \(self.filePath) created")
        }
        catch let error as NSError{
            print("could't create file: \(error)")
        }
    }
    
    func write(fContent: String){
        
        let content: String = fContent
        
        do {
            try content.write(toFile: self.filePath, atomically: true, encoding: String.Encoding.utf8)
            
            print("File \(self.filePath) created")
        }
        catch let error as NSError{
            print("could't create file: \(error)")
        }

    }
    
    func writeJSON(content: String)
    {
        let data = content.data(using: String.Encoding.utf8)!
        
        if let file = FileHandle(forWritingAtPath:self.filePath)
        {
            file.write(data)
        }
    }
    
    func read() -> String {
        
        var content: String = ""
        
        do {
            content = try NSString(contentsOfFile: self.filePath, encoding: String.Encoding.utf8.rawValue) as String
            
            print("File \(self.filePath) created")
        }
        catch let error as NSError{
            print("could't create file: \(error)")
        }
        
        return content
    }
    
    func delete()
    {
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(atPath: self.filePath)
        }
        catch let error as NSError{
            print("Cant't delete file \(self.filePath) \(error)")
        }
    }
    
    func gzip()
    {
        let path = self.filePath
        
        let pathDest = path + ".gz"
        
        let new_file = "file://" + path + ".gz"
        
        let newFileURL = URL(string: new_file)
        let data = path.data(using: String.Encoding.utf8)
        
        NVHTarGzip.sharedInstance().gzipFile(atPath: path, toPath: pathDest, completion: {(_ gzipError: Error?) -> Void in
            
            if gzipError != nil{
                print("Error gzipping \(gzipError)")
            }
        })
        
        NotificationCenter.default.addObserver(forName:Notification.Name(rawValue:"Gzip"), object:nil, queue:nil, using:self.catchNotification)
        
        NotificationCenter.default.post(name:Notification.Name(rawValue:"Gzip"),
                object: nil,
                userInfo: ["message":"Created backup!", "date":Date()])
    }
    
    func catchNotification(notification:Notification) -> Void {
        print("Catch notification")        
//        guard let userInfo = notification.userInfo,
//            let message  = userInfo["message"] as? String,
//            let date     = userInfo["date"]    as? Date else {
//                print("No userInfo found in notification")
//                return
//        }
//        
//        let alert = UIAlertController(title: "Notification!",
//                                      message:"\(message) received at \(date)",
//            preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//        present(alert, animated: true, completion: nil)
    }
    
    func gunzip(fileName: String)
    {
        
    }
}
