//
//  ViewController.swift
//  withyou
//
//  Created by Abdullah on 06/05/1446 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController,UITextFieldDelegate{
    
    let loginToList = "LogintoList"
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailText.delegate = self
        passwordText.delegate = self
        
        // إضافة Gesture Recognizer لإخفاء الكيبورد عند النقر على الشاشة
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // التحقق من حالة تسجيل الدخول عند تحميل الشاشة
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: self?.loginToList ?? "", sender: nil)
            }
        }
    }
    
    @objc func dismissKeyboard() {
        // إخفاء الكيبورد
        view.endEditing(true)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty else {
            showAlert(title: "خطأ", message: "يرجى ملء جميع الحقول.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showAlert(title: "فشل تسجيل الدخول", message: error.localizedDescription)
            } else {
                // تسجيل الدخول ناجح
                UserDefaults.standard.set(email, forKey: "userEmail")
                self?.performSegue(withIdentifier: self?.loginToList ?? "", sender: nil)
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        let alert = UIAlertController(title: "تسجيل", message: "تسجيل حساب جديد", preferredStyle: .alert)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "أدخل بريدك الإلكتروني"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "أدخل كلمة المرور"
        }
        
        let saveAction = UIAlertAction(title: "حفظ", style: .default) { [weak self] _ in
            guard let emailField = alert.textFields?[0].text,
                  let passwordField = alert.textFields?[1].text,
                  !emailField.isEmpty, !passwordField.isEmpty else {
                self?.showAlert(title: "خطأ", message: "يرجى ملء جميع الحقول.")
                return
            }
            
            Auth.auth().createUser(withEmail: emailField, password: passwordField) { authResult, error in
                if let error = error {
                    self?.showAlert(title: "فشل التسجيل", message: error.localizedDescription)
                } else {
                    // تسجيل جديد ناجح
                    UserDefaults.standard.set(emailField, forKey: "userEmail")
                    self?.performSegue(withIdentifier: self?.loginToList ?? "", sender: nil)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailText {
            passwordText.becomeFirstResponder()
        } else if textField == passwordText {
            loginPressed(self) // تنفيذ تسجيل الدخول عند الضغط على "Next"
        }
        return true
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "موافق", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
