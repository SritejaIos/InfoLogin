//
//  SignUPViewController.swift
//  InfoLogin
//
//  Created by Sriteja Thuraka on 12/1/16.
//  Copyright © 2016 Sriteja Thuraka. All rights reserved.
//

import UIKit

class SignUPViewController: UIViewController {
    
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    var databasePath = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("contacts.db").path
        
        if !filemgr.fileExists(atPath: databasePath as String) {
            
            let contactDB = FMDatabase(path: databasePath as String)
            
            if contactDB == nil {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            
            if (contactDB?.open())! {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, FIRSTNAME TEXT, LASTNAME TEXT, AGE TEXT, EMAIL TEXT, PASSWORD TEXT)"
                if !(contactDB?.executeStatements(sql_stmt))! {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                contactDB?.close()
            } else {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
        }
      
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if (contactDB?.open())! {
            
            let insertSQL = "INSERT INTO CONTACTS (firstname, lastname,age,email,password) VALUES ('\(firstnameText.text!)', '\(lastnameText.text!)', '\(ageText.text!)','\(emailText.text)', '\(passwordText.text)')"
            
            let result = contactDB?.executeUpdate(insertSQL,
                                                  withArgumentsIn: nil)
            
            if !result! {
                statusLabel.text = "Failed to add contact"
                print("Error: \(contactDB?.lastErrorMessage())")
            } else {
                statusLabel.text = "Contact Added"
                firstnameText.text = ""
                lastnameText.text = ""
                ageText.text = ""
                emailText.text = ""
                passwordText.text = ""
            }
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        
        
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    


}
