//
//  LoginViewController.swift
//  InfoLogin
//
//  Created by Sriteja Thuraka on 12/1/16.
//  Copyright © 2016 Sriteja Thuraka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
   
    var databasePath = String()
    var signUp = SignUPViewController()
    
    @IBAction func loginButton(_ sender: Any) {
        var userName = usernameText.text
        var password = passwordText.text
        let contactDB = FMDatabase(path: databasePath as String)
        if (contactDB?.open())! {
            let querySQL = "SELECT email, password FROM CONTACTS WHERE name = '\(signUp.emailText)'"
            
            var results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            if  results?.next() == true{
                userName = ""
                password = ""
                print("sucess")
            }else{
                print("error")
            }
            contactDB?.close()
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
