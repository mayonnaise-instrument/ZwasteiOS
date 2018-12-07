//
//  HomeVC.swift
//  Zwaste
//
//  Created by Braxton Madison on 12/5/18.
//  Copyright © 2018 GeorgiaTech. All rights reserved.
//

import UIKit
import FirebaseAuth
class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func trackerButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "trackerButtonSegue", sender: self)
    }
    @IBAction func logoutButtonClick(_ sender: Any) {
        var signOutSuccess = false
        do {
            try Auth.auth().signOut()
            signOutSuccess = true
        } catch {
            print("Logout failed.")
        }
        if signOutSuccess {
            performSegue(withIdentifier: "logoutButtonSegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutButtonSegue" {
            //pass info to login screen here
        }
        if segue.identifier == "trackerButtonSegue" {
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
