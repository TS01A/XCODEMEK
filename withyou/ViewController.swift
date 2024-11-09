//
//  ViewController.swift
//  withyou
//
//  Created by Abdullah on 06/05/1446 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    let loginToList = "LogintoList"
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard
            let email = emailText.text,
            let password = passwordText.text,
            email.count > 0,
            password.count > 0
        else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error,user == nil {
                let alret = UIAlertController(title: "Login in falied", message: error.localizedDescription, preferredStyle: .alert)
                alret.addAction(UIAlertAction(title:"Ok",style:.default))
                self.present(alret, animated: true, completion: nil)
            }else{
                Auth.auth().addStateDidChangeListener() {
                    auth ,user in
                    if user != nil {
                        self.performSegue(withIdentifier: self.loginToList, sender: nil)
                    }
                    
                }
            }
            
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
