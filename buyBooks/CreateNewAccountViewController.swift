//
//  CreateNewAccountViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/15/16.
//  Copyright © 2016 St Marys. All rights reserved.
//


import UIKit
import Firebase

class CreateNewAccountViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        passwordField2.delegate = self
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        let password2 = passwordField2.text
        
        // make a field for display name
        
        //print(email)
        //print(password)
        //print(password2)
        
        if (email != "" && password != "" && password2 != "" ) && (password == password2){
            
            // Set Email and Password for the New User.
            
            FIRAuth.auth()!.createUserWithEmail(email!, password: password!, completion: {
                (authData, error) -> Void in
                
                if error != nil
                {
                    
                    // There was a problem.
                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
                    
                }
                else
                {
                   /*
                    // Create and Login the New User with authUser
                    DataService.dataService.baseRef.authUser(email, password: password, withCompletionBlock: {(error, authData) -> Void in
                        
                        let user = ["provider": authData.provider!, "email": email!]
                        
                        // Seal the deal in DataService.swift.
                        DataService.dataService.createNewAccount(authData.uid, user: user)
                    })
                    */
                    // make the class then store the data locally
                    //let currentUser = DataService.dataService.
                    //let tempUser = Rider(authData: DataService.dataService.CURRENT_USER_REF)
                    
                    
                    
                    // Store the uid for future access - handy! 
                    //let storage = NSUserDefaults.standardUserDefaults()//.setValue(authData ["uid"], forKey: "uid")
                    
                    
                    //storage.setObject(, forKey: )
                    
                    // Enter the app.
                    self.performSegueWithIdentifier("NewUserLoggedIn", sender: nil)
                }
            })
            
        } else {
            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and a username.")
        }
        
    }
    
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
  
    
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
}
extension CreateNewAccountViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(textField: UITextField) {
        //add something may be?
        
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
}
