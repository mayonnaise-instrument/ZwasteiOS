//
//  ViewController.swift
//  Zwaste
//
//  Created by Braxton Madison on 11/23/18.
//  Copyright © 2018 GeorgiaTech. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    //array of the locations from firebase
    //Radio Button for User Type:
    @IBOutlet weak var radioBtn: DLRadioButton!
    var userType = "User"
    @IBAction func radioAction(_ sender: DLRadioButton) {
        //tag1 is User, tag2 is Location Employee, tag3 is Manager
        if sender.tag == 1 {
            print("User")
        } else if sender.tag == 2 {
            userType = "Location Employee"
        } else if sender.tag == 3 {
            userType = "Manager"
        } else {
            userType = "Please select a user type."
        }
    }
    //Outlets for the login page and login func:
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var feedbackMessage: UILabel!
    @IBAction func loginButtonClicked(_ sender: Any) {
        login()
    }
    //Outlets for the signup page and signup fun (su = signup):
    @IBOutlet weak var suNameField: UITextField!
    @IBOutlet weak var suEmailField: UITextField!
    @IBOutlet weak var suPasswordField: UITextField!
    @IBOutlet weak var suSubmitButton: UIButton!
    @IBOutlet weak var suCancelButton: UIButton!
    @IBOutlet weak var suFeedbackMessage: UILabel!
    @IBAction func suSubmitButtonClicked(_ sender: Any) {
        signup()
    }
    
    
    //firebase realtime database:
    var databaseRefer: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    //Default function:
    override func viewDidLoad() {
        super.viewDidLoad()
        if signUpSuccess == true {
            feedbackMessage.text = "Sign up successful."
            signUpSuccess = false
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Login Function:
    func login() {
        if self.emailField.text == "" || self.passwordField.text == "" {
            feedbackMessage.text = "Please enter your email and password."
        } else if !(self.emailField.text?.contains("@"))! || !(self.emailField.text?.contains("."))! {
            feedbackMessage.text = "Please enter a valid email."
        } else if (self.passwordField.text?.count)! < 5 {
            feedbackMessage.text = "Password must be at least 5 characters."
        } else {
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (user, error) in
                if error == nil {
                    self.feedbackMessage.text = "You have successfully logged in."
                    self.performSegue(withIdentifier: "loginButtonSegue", sender: self)
                } else {
                    self.feedbackMessage.text = "Login failed. Please try again."
                }
            }
            
        }
    }
    //User structure for database
    struct User {
        var emailID = ""
        var id = ""
        var name = ""
        var password = ""
        var userType = ""
    }
      //Signup Function:
    func signup() {
        var userData = User()
        let caps = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        let nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let special = ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "?", "<", ">", ",", ".", ":", "{", "}", "|"]
        if self.suEmailField.text == "" || self.suPasswordField.text == "" || self.suNameField.text == "" {
            suFeedbackMessage.text = "Please enter name, email and password."
        } else if !(self.suEmailField.text?.contains("@"))! || !(self.suEmailField.text?.contains("."))! {
            suFeedbackMessage.text = "Please enter a valid email."
        } else if (self.suPasswordField.text?.count)! < 8 {
            suFeedbackMessage.text = "Password must be at least 8 characters."
        } else if !caps.contains(where: (suPasswordField.text?.contains)!) {
            suFeedbackMessage.text = "Password must contain a capital letter."
        } else if !nums.contains(where: (suPasswordField.text?.contains)!) {
            suFeedbackMessage.text = "Password must contain a number."
        } else if !special.contains(where: (suPasswordField.text?.contains)!) {
            suFeedbackMessage.text = "Password must contain a special character."
        } else {
            Auth.auth().createUser(withEmail: suEmailField.text!, password: suPasswordField.text!) { (user, error) in
                if error == nil {
                    //update database:
                    userData.emailID = self.suEmailField.text ?? ""
                    userData.password = self.suPasswordField.text ?? ""
                    userData.name = self.suNameField.text ?? ""
                    userData.userType = self.userType
                    userData.id = self.suNameField.text ?? ""
                    self.databaseRefer = Database.database().reference().child("users") //making a reference to that piece of the database
                    let key = self.databaseRefer.childByAutoId().key //generating a key
                    let userToAdd = ["key": key, "emailID": userData.emailID, "id": userData.id, "name": userData.name, "password": userData.password, "userType": userData.userType] //making a Dictionary of the user
                    self.databaseRefer.child(key!).setValue(userToAdd) //adding the Dictionary to the database
                    //perform segue to go to the LoginView
                    self.performSegue(withIdentifier: "submitButtonSegue", sender: self)
                } else {
                    self.suFeedbackMessage.text = "Sign up failed."
                }
            }
        }
        
    }
    //The code below lets the loginView know that you have logedin successful and then in the viewDidLoad it updates the message to say signup successful
    var signUpSuccess = false
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submitButtonSegue" {
            let destination = segue.destination as! ViewController
            destination.signUpSuccess = true
        } else if segue.identifier == "loginButtonSegue" {
            let destination = segue.destination as! HomeVC
        }
    }


}

