//
//  AccointViewController.swift
//  
//
//  Created by Abdullah on 16/05/1446 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class AccointViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var copyInstructionLabel: UILabel!
    
    @IBOutlet weak var emailDisplay: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // إعداد العبارة "مرحبا بك"
        titleLabel.text = "مرحبا بك"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)

        // إعداد الصورة
        profileImage.image = UIImage(systemName: "person.crop.circle.fill")
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.lightGray.cgColor

        // إعداد نص تعليمات النسخ
        copyInstructionLabel.text = "يمكنك نسخ البريد الإلكتروني بالنقر عليه"
        copyInstructionLabel.textAlignment = .center
        copyInstructionLabel.font = UIFont.systemFont(ofSize: 14)

        // استرجاع البريد الإلكتروني
        if let email = UserDefaults.standard.string(forKey: "userEmail") {
            emailDisplay.text = email
            emailDisplay.isEditable = false
            emailDisplay.isSelectable = true
        } else {
            emailDisplay.text = "البريد الإلكتروني غير متوفر"
            emailDisplay.isEditable = false
            emailDisplay.isSelectable = false
        }

        // تعيين حجم خط البريد الإلكتروني
        emailDisplay.font = UIFont.systemFont(ofSize: 18)

        // إضافة إيماءة التفاعل مع الصورة
        let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(pickProfileImage))
        profileImage.addGestureRecognizer(profileImageGesture)
        profileImage.isUserInteractionEnabled = true

        // إعداد إيماءة التفاعل مع البريد الإلكتروني
        let emailTapGesture = UITapGestureRecognizer(target: self, action: #selector(copyEmail))
        emailDisplay.addGestureRecognizer(emailTapGesture)

        // إعداد القيود
        setupConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // جعل الصورة دائرية
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
    }

    @objc func pickProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func copyEmail() {
        UIPasteboard.general.string = emailDisplay.text
        
        let alert = UIAlertController(title: "تم النسخ", message: "البريد الإلكتروني قد تم نسخه إلى الحافظة.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        emailDisplay.translatesAutoresizingMaskIntoConstraints = false
        copyInstructionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // قيود عبارة الترحيب
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // قيود الصورة
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            
            // قيود عرض البريد الإلكتروني
            emailDisplay.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            emailDisplay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailDisplay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailDisplay.heightAnchor.constraint(equalToConstant: 50),
            
            // قيود تعليمات النسخ
            copyInstructionLabel.topAnchor.constraint(equalTo: emailDisplay.bottomAnchor, constant: 10),
            copyInstructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "toLoginpage", sender: nil)
            
        }catch let signOutError as NSError{
            print("Eroor logout:%@",signOutError)
        }
    }

    
    
     
    
} //class
    
    

